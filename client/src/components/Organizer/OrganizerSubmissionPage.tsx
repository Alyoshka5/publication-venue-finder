import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../Auth/useAuth'
import type {
  ConferenceSeriesOption,
  OrganizationOption,
  RequestMetaResponse,
  VenueRequestPayload
} from '../../models/requests'
import style from './OrganizerSubmissionPage.module.css'

const emptyPayload: VenueRequestPayload = {
  existingSeriesId: null,
  existingOrgId: null,
  newOrganizationName: '',
  newOrganizationWebsite: '',
  newOrganizationSociety: '',
  newOrganizationPublisher: '',
  newOrganizationUniversity: '',
  newSeriesName: '',
  newSeriesAcronym: '',
  newSeriesDescription: '',
  typicalMonth: null,
  typicalCityPolicy: '',
  tier: '',
  year: new Date().getFullYear() + 1,
  title: '',
  startDate: null,
  endDate: null,
  city: '',
  country: '',
  submissionDeadline: null,
  cfpUrl: '',
  callForPapers: ''
}

const monthOptions = [
  { value: 1, label: 'January' },
  { value: 2, label: 'February' },
  { value: 3, label: 'March' },
  { value: 4, label: 'April' },
  { value: 5, label: 'May' },
  { value: 6, label: 'June' },
  { value: 7, label: 'July' },
  { value: 8, label: 'August' },
  { value: 9, label: 'September' },
  { value: 10, label: 'October' },
  { value: 11, label: 'November' },
  { value: 12, label: 'December' }
]

export default function OrganizerSubmissionPage() {
  const { currentUser } = useAuth()
  const [organizations, setOrganizations] = useState<OrganizationOption[]>([])
  const [conferenceSeries, setConferenceSeries] = useState<ConferenceSeriesOption[]>([])
  const [usedYearsBySeries, setUsedYearsBySeries] = useState<Record<number, number[]>>({})
  const [payload, setPayload] = useState<VenueRequestPayload>(emptyPayload)
  const [useExistingSeries, setUseExistingSeries] = useState(true)
  const [useExistingOrganization, setUseExistingOrganization] = useState(true)
  const [loadingMeta, setLoadingMeta] = useState(true)
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState<string | null>(null)

  const canSubmit = currentUser?.role === 'organizer'

  useEffect(() => {
    if (!canSubmit) return

    const controller = new AbortController()

    const run = async () => {
      try {
        setLoadingMeta(true)
        setError(null)
        const res = await fetch('/api/requests/meta', { signal: controller.signal })
        if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`)
        const data = (await res.json()) as RequestMetaResponse
        setOrganizations(data.organizations)
        setConferenceSeries(data.conferenceSeries)
        setUsedYearsBySeries(
          Object.fromEntries(data.usedYearsBySeries.map((entry) => [entry.seriesId, entry.years]))
        )
      } catch (e) {
        if (e instanceof DOMException && e.name === 'AbortError') return
        setError(e instanceof Error ? e.message : String(e))
      } finally {
        setLoadingMeta(false)
      }
    }

    run()
    return () => controller.abort()
  }, [canSubmit])

  const selectedSeries = useMemo(
    () => conferenceSeries.find((entry) => entry.seriesId === payload.existingSeriesId) ?? null,
    [conferenceSeries, payload.existingSeriesId]
  )
  const selectedSeriesYears = selectedSeries ? (usedYearsBySeries[selectedSeries.seriesId] ?? []) : []
  const normalizedNewOrgName = payload.newOrganizationName.trim().toLowerCase()
  const normalizedNewOrgWebsite = payload.newOrganizationWebsite.trim()
  const normalizedNewSeriesName = payload.newSeriesName.trim().toLowerCase()
  const normalizedNewSeriesAcronym = payload.newSeriesAcronym.trim().toLowerCase()

  const updatePayload = <K extends keyof VenueRequestPayload>(key: K, value: VenueRequestPayload[K]) => {
    setPayload((current) => ({ ...current, [key]: value }))
  }

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    if (!currentUser) return

    try {
      setSubmitting(true)
      setError(null)
      setSuccess(null)

      const nextPayload: VenueRequestPayload = {
        ...payload,
        existingSeriesId: useExistingSeries ? payload.existingSeriesId : null,
        existingOrgId: useExistingSeries ? null : (useExistingOrganization ? payload.existingOrgId : null),
        newOrganizationName: useExistingSeries || useExistingOrganization ? '' : payload.newOrganizationName.trim(),
        newOrganizationWebsite: useExistingSeries || useExistingOrganization ? '' : payload.newOrganizationWebsite.trim(),
        newOrganizationSociety: useExistingSeries || useExistingOrganization ? '' : payload.newOrganizationSociety.trim(),
        newOrganizationPublisher: useExistingSeries || useExistingOrganization ? '' : payload.newOrganizationPublisher.trim(),
        newOrganizationUniversity: useExistingSeries || useExistingOrganization ? '' : payload.newOrganizationUniversity.trim(),
        newSeriesName: useExistingSeries ? '' : payload.newSeriesName.trim(),
        newSeriesAcronym: useExistingSeries ? '' : payload.newSeriesAcronym.trim(),
        newSeriesDescription: useExistingSeries ? '' : payload.newSeriesDescription.trim(),
        typicalMonth: useExistingSeries ? null : payload.typicalMonth,
        typicalCityPolicy: useExistingSeries ? '' : payload.typicalCityPolicy.trim(),
        tier: useExistingSeries ? '' : payload.tier.trim(),
        title: payload.title.trim(),
        city: payload.city.trim(),
        country: payload.country.trim(),
        cfpUrl: payload.cfpUrl.trim(),
        callForPapers: payload.callForPapers.trim()
      }

      if (useExistingSeries && nextPayload.existingSeriesId && selectedSeriesYears.includes(nextPayload.year)) {
        throw new Error('That conference series already has a venue instance for the selected year.')
      }
      if (!useExistingSeries && !useExistingOrganization) {
        const duplicateOrganization = organizations.find((entry) =>
          entry.name.trim().toLowerCase() === normalizedNewOrgName || entry.website === normalizedNewOrgWebsite
        )
        if (duplicateOrganization) {
          throw new Error('That organization already exists. Choose the existing organization option instead.')
        }
      }
      if (!useExistingSeries) {
        const targetOrgId = useExistingOrganization ? nextPayload.existingOrgId : null
        if (targetOrgId && normalizedNewSeriesName) {
          const duplicateSeries = conferenceSeries.find((entry) =>
            entry.orgId === targetOrgId && (
              entry.name.trim().toLowerCase() === normalizedNewSeriesName ||
              (normalizedNewSeriesAcronym !== '' && (entry.acronym ?? '').trim().toLowerCase() === normalizedNewSeriesAcronym)
            )
          )
          if (duplicateSeries) {
            throw new Error('That series already exists for the selected organization. Use the existing series option instead.')
          }
        }
      }

      const currentYear = new Date().getFullYear()
      if (nextPayload.year < currentYear) {
        throw new Error('Venue year must be this year or later.')
      }
      if (nextPayload.startDate && new Date(nextPayload.startDate).getUTCFullYear() !== nextPayload.year) {
        throw new Error('Start date must fall within the selected venue year.')
      }
      if (nextPayload.endDate && new Date(nextPayload.endDate).getUTCFullYear() !== nextPayload.year) {
        throw new Error('End date must fall within the selected venue year.')
      }
      if (nextPayload.startDate && nextPayload.endDate && nextPayload.endDate < nextPayload.startDate) {
        throw new Error('End date must be on or after the start date.')
      }
      if (nextPayload.submissionDeadline && new Date(nextPayload.submissionDeadline).getUTCFullYear() > nextPayload.year) {
        throw new Error('Submission deadline cannot fall after the selected venue year.')
      }
      if (nextPayload.startDate && nextPayload.submissionDeadline && nextPayload.submissionDeadline >= nextPayload.startDate) {
        throw new Error('Submission deadline must be before the conference start date.')
      }

      const res = await fetch('/api/requests', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          submittedByUserId: currentUser.userId,
          payload: nextPayload
        })
      })

      const data = (await res.json()) as { requestId?: number; error?: string }
      if (!res.ok) {
        throw new Error(data.error ?? 'Failed to create request')
      }

      setSuccess(`Request #${data.requestId} has been submitted for admin review.`)
      setPayload(emptyPayload)
      setUseExistingSeries(true)
      setUseExistingOrganization(true)
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e))
    } finally {
      setSubmitting(false)
    }
  }

  if (!canSubmit) {
    return (
      <main className="main">
        <section className={style.header}>
          <div className={style.headerContent}>
            <p className={style.eyebrow}>Organizer Tools</p>
            <h1 className={style.title}>Organizer Access Required</h1>
            <p className={style.subtitle}>Sign in with an organizer account to submit new venue-instance requests.</p>
            <p className={style.links}>
              <Link to="/">Find Venues</Link>
              <Link to="/login">Log In</Link>
            </p>
          </div>
        </section>
      </main>
    )
  }

  return (
    <main className="main">
      <section className={style.header}>
        <div className={style.headerContent}>
          <p className={style.eyebrow}>Organizer Tools</p>
          <h1 className={style.title}>Submit Venue Request</h1>
          <p className={style.subtitle}>
            Propose either a new instance for an existing conference series or a brand-new series and organization.
          </p>
        </div>
      </section>

      <section className={`card ${style.formCard}`}>
        <form className={style.form} onSubmit={handleSubmit}>
          <label className={style.field}>
            <span>Request path</span>
            <select
              value={useExistingSeries ? 'existing' : 'new'}
              onChange={(e) => setUseExistingSeries(e.target.value === 'existing')}
            >
              <option value="existing">Add a new year to an existing series</option>
              <option value="new">Create a new conference series</option>
            </select>
          </label>

          {useExistingSeries ? (
            <label className={style.field}>
              <span>Existing conference series</span>
              <select
                value={payload.existingSeriesId ?? ''}
                onChange={(e) => updatePayload('existingSeriesId', e.target.value ? Number(e.target.value) : null)}
                required
                disabled={loadingMeta}
              >
                <option value="">Select a series</option>
                {conferenceSeries.map((entry) => (
                  <option key={entry.seriesId} value={entry.seriesId}>
                    {entry.organization} - {entry.acronym ? `${entry.acronym} (${entry.name})` : entry.name}
                  </option>
                ))}
              </select>
              {selectedSeries ? (
                <small className={style.hint}>
                  Requesting a new year for {selectedSeries.name}. Existing years: {selectedSeriesYears.join(', ') || 'none'}.
                </small>
              ) : null}
            </label>
          ) : (
            <>
              <label className={style.field}>
                <span>Organization source</span>
                <select
                  value={useExistingOrganization ? 'existing' : 'new'}
                  onChange={(e) => setUseExistingOrganization(e.target.value === 'existing')}
                >
                  <option value="existing">Use an existing organization</option>
                  <option value="new">Create a new organization</option>
                </select>
              </label>

              {useExistingOrganization ? (
                <label className={style.field}>
                  <span>Existing organization</span>
                  <select
                    value={payload.existingOrgId ?? ''}
                    onChange={(e) => updatePayload('existingOrgId', e.target.value ? Number(e.target.value) : null)}
                    required
                    disabled={loadingMeta}
                  >
                    <option value="">Select an organization</option>
                    {organizations.map((entry) => (
                      <option key={entry.orgId} value={entry.orgId}>{entry.name}</option>
                    ))}
                  </select>
                </label>
              ) : (
                <div className={style.grid}>
                  <label className={style.field}>
                    <span>New organization name</span>
                    <input
                      value={payload.newOrganizationName}
                      onChange={(e) => updatePayload('newOrganizationName', e.target.value)}
                      required={!useExistingOrganization}
                    />
                  </label>
                  <label className={style.field}>
                    <span>Website</span>
                    <input
                      type="url"
                      value={payload.newOrganizationWebsite}
                      onChange={(e) => updatePayload('newOrganizationWebsite', e.target.value)}
                      required={!useExistingOrganization}
                    />
                  </label>
                  <label className={style.field}>
                    <span>Society</span>
                    <input value={payload.newOrganizationSociety} onChange={(e) => updatePayload('newOrganizationSociety', e.target.value)} />
                  </label>
                  <label className={style.field}>
                    <span>Publisher</span>
                    <input value={payload.newOrganizationPublisher} onChange={(e) => updatePayload('newOrganizationPublisher', e.target.value)} />
                  </label>
                  <label className={style.field}>
                    <span>University</span>
                    <input value={payload.newOrganizationUniversity} onChange={(e) => updatePayload('newOrganizationUniversity', e.target.value)} />
                  </label>
                </div>
              )}

              <div className={style.grid}>
                <label className={style.field}>
                  <span>Series name</span>
                  <input value={payload.newSeriesName} onChange={(e) => updatePayload('newSeriesName', e.target.value)} required={!useExistingSeries} />
                </label>
                <label className={style.field}>
                  <span>Acronym</span>
                  <input value={payload.newSeriesAcronym} onChange={(e) => updatePayload('newSeriesAcronym', e.target.value)} />
                </label>
                <label className={style.field}>
                  <span>Typical month</span>
                  <select
                    value={payload.typicalMonth ?? ''}
                    onChange={(e) => updatePayload('typicalMonth', e.target.value ? Number(e.target.value) : null)}
                    required={!useExistingSeries}
                  >
                    <option value="">Select a month</option>
                    {monthOptions.map((month) => (
                      <option key={month.value} value={month.value}>{month.label}</option>
                    ))}
                  </select>
                </label>
                <label className={style.field}>
                  <span>Tier</span>
                  <input value={payload.tier} onChange={(e) => updatePayload('tier', e.target.value)} />
                </label>
              </div>
              <label className={style.field}>
                <span>Typical city policy</span>
                <input
                  value={payload.typicalCityPolicy}
                  onChange={(e) => updatePayload('typicalCityPolicy', e.target.value)}
                  required={!useExistingSeries}
                />
              </label>
              <label className={style.field}>
                <span>Series description</span>
                <textarea value={payload.newSeriesDescription} onChange={(e) => updatePayload('newSeriesDescription', e.target.value)} rows={3} />
              </label>
            </>
          )}

          <div className={style.sectionTitle}>Requested venue instance</div>
          <div className={style.grid}>
            <label className={style.field}>
              <span>Year</span>
              <input type="number" min={new Date().getFullYear()} value={payload.year} onChange={(e) => updatePayload('year', Number(e.target.value))} required />
            </label>
            <label className={style.field}>
              <span>Title</span>
              <input value={payload.title} onChange={(e) => updatePayload('title', e.target.value)} required />
            </label>
            <label className={style.field}>
              <span>City</span>
              <input value={payload.city} onChange={(e) => updatePayload('city', e.target.value)} required />
            </label>
            <label className={style.field}>
              <span>Country</span>
              <input value={payload.country} onChange={(e) => updatePayload('country', e.target.value)} required />
            </label>
            <label className={style.field}>
              <span>Start date</span>
              <input type="date" value={payload.startDate ?? ''} onChange={(e) => updatePayload('startDate', e.target.value || null)} />
            </label>
            <label className={style.field}>
              <span>End date</span>
              <input type="date" value={payload.endDate ?? ''} onChange={(e) => updatePayload('endDate', e.target.value || null)} />
            </label>
            <label className={style.field}>
              <span>Submission deadline</span>
              <input type="date" value={payload.submissionDeadline ?? ''} onChange={(e) => updatePayload('submissionDeadline', e.target.value || null)} />
            </label>
            <label className={style.field}>
              <span>CFP URL</span>
              <input type="url" value={payload.cfpUrl} onChange={(e) => updatePayload('cfpUrl', e.target.value)} />
            </label>
          </div>

          <label className={style.field}>
            <span>Call for papers / notes</span>
            <textarea value={payload.callForPapers} onChange={(e) => updatePayload('callForPapers', e.target.value)} rows={4} />
          </label>

          {error ? <div className={style.error}>{error}</div> : null}
          {success ? <div className={style.success}>{success}</div> : null}

          <button className={style.submitButton} type="submit" disabled={submitting || loadingMeta}>
            {submitting ? 'Submitting…' : 'Submit request'}
          </button>
        </form>
      </section>
    </main>
  )
}
