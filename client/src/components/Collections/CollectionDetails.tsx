import { useEffect, useState } from 'react';
import style from './CollectionDetails.module.css';
import { formatDate, formatLocation } from '../../helpers/formatting';
import { useParams } from 'react-router-dom';
import type { Venue } from '../../models/venues';
import type { Collection } from '../../models/collections';

export default function CollectionDetails() {
	const [venues, setVenues] = useState<Venue[]>([]);
	const [collection, setCollection] = useState<Collection>()
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
	const { id } = useParams()
	
	useEffect(() => {
		const controller = new AbortController()

		const getCollectionInfo = async () => {
      try {
        const res = await fetch(`/api/collections/${id}`, { signal: controller.signal })
        if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`)
        const data = (await res.json()) as Collection[]
				console.log(data)
        setCollection(data[0])
      } catch (e) {
        if (e instanceof DOMException && e.name === 'AbortError') return
        setError(e instanceof Error ? e.message : String(e))
      }
    }

		const getCollectionVenues = async () => {
      try {
        const res = await fetch(`/api/collections/${id}/venues`, { signal: controller.signal })
        if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`)
        const data = (await res.json()) as Venue[]
        setVenues(Array.isArray(data) ? data : [])
      } catch (e) {
        if (e instanceof DOMException && e.name === 'AbortError') return
        setError(e instanceof Error ? e.message : String(e))
      }
    }

		const getCollectionDetails = async () => {
			try {
				setLoading(true)
				setError(null)
				await getCollectionInfo();
				await getCollectionVenues();
			} catch (e) {
				if (e instanceof DOMException && e.name === 'AbortError') return
				setError(e instanceof Error ? e.message : String(e))
			} finally {
				setLoading(false)
			}
		}

		getCollectionDetails()
		return () => controller.abort()
	}, [])

  useEffect(() => {
    const controller = new AbortController()

    const getCollectionVenues = async () => {
      try {
        setLoading(true)
        setError(null)
        const res = await fetch(`/api/collections/${id}/venues`, { signal: controller.signal })
        if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`)
        const data = (await res.json()) as Venue[]
        setVenues(Array.isArray(data) ? data : [])
      } catch (e) {
        if (e instanceof DOMException && e.name === 'AbortError') return
        setError(e instanceof Error ? e.message : String(e))
      } finally {
        setLoading(false)
      }
    }

    getCollectionVenues()
    return () => controller.abort()
  }, [])

  return (
      <main className="main">
      <section className={`card ${style.contentContainer}`}>
        <div className="cardHeader">
          <h2>{collection?.name || 'Collection'}</h2>
					<div className="meta">
            {loading
              ? 'Loading…'
              : `${venues.length} result${venues.length === 1 ? '' : 's'}`}
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
          <div className="tableWrap" role="region" aria-label="collection Venues table" tabIndex={0}>
            <table className="table">
              <thead>
                <tr>
                  <th>Venue</th>
                  <th>Org</th>
                  <th>Year</th>
                  <th>Location</th>
                  <th>Deadline</th>
                </tr>
              </thead>
              <tbody>
                {loading ? (
                  <tr>
                    <td colSpan={5} className="tableEmpty">
                      Loading collection venues…
                    </td>
                  </tr>
                ) : venues.length === 0 ? (
                  <tr>
                    <td colSpan={5} className="tableEmpty">
                      No results.
                    </td>
                  </tr>
                ) : (
                  venues.map((v) => (
                    <tr key={`${v.seriesId}-${v.year}`} className={style.venueRow}>
                      <td>
                        <div className={style.venueCell}>
                          <div className={style.venueTop}>
                            <span className="pill">{v.acronym ?? '—'}</span>
                            <span className={style.venueTitle}>{v.title}</span>
                          </div>
                        </div>
                      </td>
                      <td className="muted">{v.organization}</td>
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
    </main>
  );
}
