import { useEffect, useMemo, useState } from 'react';
import type { UpcomingVenue } from '../../models/venues';
import style from './VenueList.module.css';

const formatDate = (value: string | null) => {
  if (!value) return '—'
  const d = new Date(value)
  if (Number.isNaN(d.getTime())) return value
  return d.toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: '2-digit' })
}

const formatLocation = (city: string, country: string) => {
  if (!city && !country) return '—'
  if (!city) return country
  if (!country) return city
  return `${city}, ${country}`
}

const formatTopics = (value: string | null) => {
  if (!value) return []
  return value
    .split(',')
    .map((topic) => topic.trim())
    .filter(Boolean)
}

export default function VenueList({
  query,
  selectedTopicId
}: {
  query: string
  selectedTopicId: string
}) {
  const [venues, setVenues] = useState<UpcomingVenue[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const controller = new AbortController()

    const run = async () => {
      try {
        setLoading(true)
        setError(null)
        const params = new URLSearchParams()
        if (selectedTopicId) params.set('topicId', selectedTopicId)
        const suffix = params.toString()
        const res = await fetch(`/api/venues/upcoming${suffix ? `?${suffix}` : ''}`, { signal: controller.signal })
        if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`)
        const data = (await res.json()) as UpcomingVenue[]
        setVenues(Array.isArray(data) ? data : [])
      } catch (e) {
        if (e instanceof DOMException && e.name === 'AbortError') return
        setError(e instanceof Error ? e.message : String(e))
      } finally {
        setLoading(false)
      }
    }

    run()
    return () => controller.abort()
  }, [selectedTopicId])

  const filteredVenues = useMemo(() => {
    const q = query.trim().toLowerCase()
    if (!q) return venues
    return venues.filter((v) => {
      return (
        (v.acronym ?? '').toLowerCase().includes(q) ||
        v.title.toLowerCase().includes(q) ||
        v.organization.toLowerCase().includes(q) ||
        formatLocation(v.city, v.country).toLowerCase().includes(q) ||
        (v.topics ?? '').toLowerCase().includes(q) ||
        String(v.year).includes(q)
      )
    })
  }, [query, venues])

  return (
      <main className="main">
      <section className="card">
        <div className="cardHeader">
          <h2>Upcoming</h2>
          <div className="meta">
            {loading
              ? 'Loading…'
              : `${filteredVenues.length} result${filteredVenues.length === 1 ? '' : 's'}`}
          </div>
        </div>

        {error ? (
          <div className="error">
            <div className="errorTitle">Backend query failed</div>
            <div className="errorBody">{error}</div>
            <div className="errorHint">
              Make sure the server is running on <code>localhost:3000</code> and the database is seeded.
            </div>
          </div>
        ) : (
          <div className="tableWrap" role="region" aria-label="Upcoming venues table" tabIndex={0}>
            <table className="table">
              <thead>
                <tr>
                  <th>Venue</th>
                  <th>Org</th>
                  <th>Topics</th>
                  <th>Year</th>
                  <th>Location</th>
                  <th>Deadline</th>
                </tr>
              </thead>
              <tbody>
                {loading ? (
                  <tr>
                    <td colSpan={6} className="tableEmpty">
                      Loading upcoming venues…
                    </td>
                  </tr>
                ) : filteredVenues.length === 0 ? (
                  <tr>
                    <td colSpan={6} className="tableEmpty">
                      No results.
                    </td>
                  </tr>
                ) : (
                  filteredVenues.map((v) => (
                    <tr key={`${v.seriesId}-${v.year}`}>
                      <td className={style.venueColumn}>
                        <div className={style.venueCell}>
                          <span className={style.venueTag}>
                            <span className="pill">{v.acronym ?? '—'}</span>
                          </span>
                          <span className={style.venueTitle}>{v.title}</span>
                        </div>
                      </td>
                      <td className="muted">{v.organization}</td>
                      <td>
                        <div className={style.topicList}>
                          {formatTopics(v.topics).length > 0 ? (
                            formatTopics(v.topics).map((topic) => (
                              <span key={`${v.seriesId}-${v.year}-${topic}`} className={style.topicPill}>
                                {topic}
                              </span>
                            ))
                          ) : (
                            <span className="muted">—</span>
                          )}
                        </div>
                      </td>
                      <td className="mono">{v.year}</td>
                      <td className="muted">{formatLocation(v.city, v.country)}</td>
                      <td className="mono">{formatDate(v.submissionDeadline)}</td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
        )}
      </section>

      <footer className="footer">
        <span className="muted">
          Query: <code>WHERE Reviewing = FALSE AND Published = FALSE</code> with optional topic filtering (limited to 50 rows)
        </span>
      </footer>
    </main>
  );
}
