import { useEffect, useState } from 'react';
import style from './CollectionList.module.css';
import type { Collection } from '../../models/collections';

const formatDate = (value: string | null) => {
  if (!value) return '—'
  const d = new Date(value)
  if (Number.isNaN(d.getTime())) return value
  return d.toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: '2-digit' })
}

export default function CollectionList() {
  const [collections, setCollections] = useState<Collection[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const controller = new AbortController()

    const getUserCollections = async () => {
      try {
        setLoading(true)
        setError(null)
        const res = await fetch('/api/collections', { signal: controller.signal })
        if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`)
        const data = (await res.json()) as Collection[]
        setCollections(Array.isArray(data) ? data : [])
      } catch (e) {
        if (e instanceof DOMException && e.name === 'AbortError') return
        setError(e instanceof Error ? e.message : String(e))
      } finally {
        setLoading(false)
      }
    }

    getUserCollections()
    return () => controller.abort()
  }, [])

  return (
      <main className="main">
      <section className={`card ${style.contentContainer}`}>
        <div className="cardHeader">
          <h2>My Collections</h2>
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
          <div className="tableWrap" role="region" aria-label="My collections table" tabIndex={0}>
            <table className="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Venues</th>
                  <th>Visibility</th>
                  <th>Created On</th>
                </tr>
              </thead>
              <tbody>
                {loading ? (
                  <tr>
                    <td colSpan={5} className="tableEmpty">
                      Loading your collections…
                    </td>
                  </tr>
                ) : collections.length === 0 ? (
                  <tr>
                    <td colSpan={5} className="tableEmpty">
                      No results.
                    </td>
                  </tr>
                ) : (
                  collections.map((c) => (
                    <tr key={`${c.collectionId}`} className={style.collectionRow}>
                      <td>
                        <div className={style.collectionCell}>
                          <div className={style.collectionTop}>
                            <span className={style.collectionTitle}>{c.name}</span>
                          </div>
                        </div>
                      </td>
                      <td className="muted">{c.venueInstanceCount}</td>
                      <td className="mono">{c.visibility}</td>
                      <td className="muted">{formatDate(c.createdAt.toString())}</td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
        )}
      </section>
    </main>
  );
}
