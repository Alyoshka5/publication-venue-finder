import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import type { UpcomingStats } from '../../models/admin'
import { useAuth } from '../Auth/useAuth'
import style from './AdminDashboard.module.css'

const emptyStats: UpcomingStats = {
  totalUpcomingPostings: 0,
  organizationStats: []
}

export default function AdminDashboard() {
  const { currentUser } = useAuth()
  const [stats, setStats] = useState<UpcomingStats>(emptyStats)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  const canViewAdmin = currentUser?.role === 'admin'

  useEffect(() => {
    if (!canViewAdmin) return

    const controller = new AbortController()

    const run = async () => {
      try {
        setLoading(true)
        setError(null)
        const res = await fetch('/api/admin/upcoming-stats', { signal: controller.signal })
        if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`)
        const data = (await res.json()) as UpcomingStats
        setStats(data)
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

  if (!canViewAdmin) {
    return (
      <main className="main">
        <section className={style.header}>
          <div className={style.headerContent}>
            <p className={style.eyebrow}>Admin Dashboard</p>
            <h1 className={style.title}>Admin Access Required</h1>
            <p className={style.subtitle}>
              Sign in with an admin account to view the aggregate posting metrics.
            </p>
            <p className={style.authLinks}>
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
          <p className={style.eyebrow}>Admin Dashboard</p>
          <h1 className={style.title}>Upcoming Posting Metrics</h1>
          <p className={style.subtitle}>
            Aggregated conference activity pulled from the same upcoming-postings dataset as the venue browser.
          </p>
        </div>
      </header>

      {error ? (
        <section className="card">
          <div className="error">
            <div className="errorTitle">Admin stats query failed</div>
            <div className="errorBody">{error}</div>
          </div>
        </section>
      ) : (
        <>
          <section className={style.statsGrid}>
            <article className={`card ${style.statCard}`}>
              <div className={style.statLabel}>Total upcoming postings</div>
              <div className={style.statValue}>
                {loading ? '—' : stats.totalUpcomingPostings}
              </div>
              <div className={style.statNote}>Count of venue instances where reviewing and published are both false.</div>
            </article>
            <article className={`card ${style.statCard}`}>
              <div className={style.statLabel}>Organizations with upcoming postings</div>
              <div className={style.statValue}>
                {loading ? '—' : stats.organizationStats.length}
              </div>
              <div className={style.statNote}>Distinct organizations represented in the grouped aggregation.</div>
            </article>
          </section>

          <section className="card">
            <div className="cardHeader">
              <h2>Most Active Organizations</h2>
              <div className="meta">
                {loading
                  ? 'Loading…'
                  : `${stats.organizationStats.length} organization${stats.organizationStats.length === 1 ? '' : 's'}`}
              </div>
            </div>

            <div className="tableWrap" role="region" aria-label="Upcoming postings by organization" tabIndex={0}>
              <table className="table">
                <thead>
                  <tr>
                    <th>Organization</th>
                    <th>Upcoming postings</th>
                  </tr>
                </thead>
                <tbody>
                  {loading ? (
                    <tr>
                      <td colSpan={2} className="tableEmpty">
                        Loading admin stats…
                      </td>
                    </tr>
                  ) : stats.organizationStats.length === 0 ? (
                    <tr>
                      <td colSpan={2} className="tableEmpty">
                        No organization stats found.
                      </td>
                    </tr>
                  ) : (
                    stats.organizationStats.map((entry) => (
                      <tr key={entry.organization}>
                        <td className={style.organizationCell}>{entry.organization}</td>
                        <td className="mono">{entry.upcomingPostings}</td>
                      </tr>
                    ))
                  )}
                </tbody>
              </table>
            </div>
          </section>
        </>
      )}
    </main>
  )
}
