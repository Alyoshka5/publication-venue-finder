import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../Auth/useAuth'
import type { AdminRequestsResponse, RequestMetaResponse, VenueRequestRecord } from '../../models/requests'
import style from './AdminReviewPage.module.css'

export default function AdminReviewPage() {
  const { currentUser } = useAuth()
  const [requests, setRequests] = useState<VenueRequestRecord[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [actingRequestId, setActingRequestId] = useState<number | null>(null)
  const [seriesLookup, setSeriesLookup] = useState<Record<number, string>>({})
  const [seriesOrganizationLookup, setSeriesOrganizationLookup] = useState<Record<number, string>>({})
  const [organizationLookup, setOrganizationLookup] = useState<Record<number, string>>({})

  const canViewAdmin = currentUser?.role === 'admin'

  useEffect(() => {
    if (!canViewAdmin) return

    const controller = new AbortController()

    const run = async () => {
      try {
        setLoading(true)
        setError(null)
        const [requestRes, metaRes] = await Promise.all([
          fetch('/api/requests/admin', { signal: controller.signal }),
          fetch('/api/requests/meta', { signal: controller.signal })
        ])
        if (!requestRes.ok) throw new Error(`API error: ${requestRes.status} ${requestRes.statusText}`)
        if (!metaRes.ok) throw new Error(`API error: ${metaRes.status} ${metaRes.statusText}`)

        const requestData = (await requestRes.json()) as AdminRequestsResponse
        const metaData = (await metaRes.json()) as RequestMetaResponse

        setRequests(requestData.requests)
        setSeriesLookup(Object.fromEntries(metaData.conferenceSeries.map((entry) => [entry.seriesId, entry.name])))
        setSeriesOrganizationLookup(Object.fromEntries(metaData.conferenceSeries.map((entry) => [entry.seriesId, entry.organization])))
        setOrganizationLookup(Object.fromEntries(metaData.organizations.map((entry) => [entry.orgId, entry.name])))
      } catch (e) {
        if (e instanceof DOMException && e.name === 'AbortError') return
        setError(e instanceof Error ? e.message : String(e))
      } finally {
        setLoading(false)
      }
    }

    run()
    return () => controller.abort()
  }, [canViewAdmin])

  const handleDecision = async (requestId: number, status: 'approved' | 'rejected') => {
    if (!currentUser) return

    try {
      setActingRequestId(requestId)
      setError(null)

      const res = await fetch(`/api/requests/admin/${requestId}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          reviewedByUserId: currentUser.userId,
          status
        })
      })

      const data = (await res.json()) as { error?: string }
      if (!res.ok) {
        throw new Error(data.error ?? 'Review action failed')
      }

      const requestRes = await fetch('/api/requests/admin')
      if (!requestRes.ok) {
        throw new Error(`API error: ${requestRes.status} ${requestRes.statusText}`)
      }
      const requestData = (await requestRes.json()) as AdminRequestsResponse
      setRequests(requestData.requests)
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e))
    } finally {
      setActingRequestId(null)
    }
  }

  if (!canViewAdmin) {
    return (
      <main className="main">
        <section className={style.header}>
          <div className={style.headerContent}>
            <p className={style.eyebrow}>Admin Review</p>
            <h1 className={style.title}>Admin Access Required</h1>
            <p className={style.subtitle}>Sign in with an admin account to review organizer submissions.</p>
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
      <header className={style.header}>
        <div className={style.headerContent}>
          <p className={style.eyebrow}>Admin Review</p>
          <h1 className={style.title}>Organizer Requests</h1>
          <p className={style.subtitle}>
            Review organizer-submitted venue requests, then approve to create the venue instance or reject to leave the catalog unchanged.
          </p>
        </div>
      </header>

      {error ? (
        <section className="card">
          <div className="error">
            <div className="errorTitle">Request review failed</div>
            <div className="errorBody">{error}</div>
          </div>
        </section>
      ) : null}

      <section className={style.requestList}>
        {loading ? (
          <section className="card">
            <div className="tableEmpty">Loading review queue…</div>
          </section>
        ) : requests.length === 0 ? (
          <section className="card">
            <div className="tableEmpty">No organizer requests found.</div>
          </section>
        ) : (
          requests.map((request) => (
            <article key={request.requestId} className={`card ${style.requestCard}`}>
              <div className={style.cardHeader}>
                <div>
                  <div className={style.cardEyebrow}>Request #{request.requestId}</div>
                  <h2 className={style.cardTitle}>{request.payload.title}</h2>
                  <div className={style.meta}>
                    Submitted by {request.submittedByName} · {new Date(request.createdAt).toLocaleString()}
                  </div>
                </div>
                <span className={`${style.statusPill} ${style[`status_${request.status}`]}`}>{request.status}</span>
              </div>

              <div className={style.summaryGrid}>
                <div><strong>Year:</strong> {request.payload.year}</div>
                <div><strong>Location:</strong> {request.payload.city}, {request.payload.country}</div>
                <div><strong>Series path:</strong> {request.payload.existingSeriesId ? (seriesLookup[request.payload.existingSeriesId] ?? `Series #${request.payload.existingSeriesId}`) : request.payload.newSeriesName}</div>
                <div><strong>Organization path:</strong> {request.payload.existingSeriesId ? (seriesOrganizationLookup[request.payload.existingSeriesId] ?? 'Uses selected series organization') : (request.payload.existingOrgId ? (organizationLookup[request.payload.existingOrgId] ?? `Org #${request.payload.existingOrgId}`) : request.payload.newOrganizationName)}</div>
                <div><strong>Submission deadline:</strong> {request.payload.submissionDeadline ?? '—'}</div>
                <div><strong>CFP URL:</strong> {request.payload.cfpUrl || '—'}</div>
              </div>

              {request.payload.callForPapers ? (
                <p className={style.notes}>{request.payload.callForPapers}</p>
              ) : null}

              {request.status === 'pending' ? (
                <div className={style.actions}>
                  <button
                    className={style.approveButton}
                    disabled={actingRequestId === request.requestId}
                    onClick={() => handleDecision(request.requestId, 'approved')}
                  >
                    {actingRequestId === request.requestId ? 'Working…' : 'Approve'}
                  </button>
                  <button
                    className={style.rejectButton}
                    disabled={actingRequestId === request.requestId}
                    onClick={() => handleDecision(request.requestId, 'rejected')}
                  >
                    Reject
                  </button>
                </div>
              ) : request.reviewedByName ? (
                <div className={style.reviewedBy}>Reviewed by {request.reviewedByName}</div>
              ) : null}
            </article>
          ))
        )}
      </section>
    </main>
  )
}
