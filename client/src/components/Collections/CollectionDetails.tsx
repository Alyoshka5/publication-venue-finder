import { useEffect, useState } from 'react';
import style from './CollectionDetails.module.css';
import { formatDate, formatLocation } from '../../helpers/formatting';
import { useNavigate, useParams } from 'react-router-dom';
import type { Venue } from '../../models/venues';
import type { Collection } from '../../models/collections';
import { Link } from 'react-router-dom';
import { Icon } from '@mdi/react';
import { mdiChevronLeft, mdiSquareEditOutline, mdiTrashCanOutline, mdiMinusCircleOutline } from '@mdi/js';

export default function CollectionDetails() {
	const [venues, setVenues] = useState<Venue[]>([]);
	const [collection, setCollection] = useState<Collection>()
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [openCollectionForm, setOpenCollectionForm] = useState<boolean>(false);
  const [collectionName, setCollectionName] = useState<string>('')
	const { id } = useParams()
  const navigate = useNavigate();
	
	useEffect(() => {
		const controller = new AbortController()

		const getCollectionInfo = async () => {
      try {
        const res = await fetch(`/api/collections/${id}`, { signal: controller.signal })
        if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`)
        const data = (await res.json()) as Collection[]
        console.log("HERE")
        console.log(data)
        setCollection(data[0])
        setCollectionName(data[0].name)
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

  const deleteCollection = async () => {
    const controller = new AbortController()

    try {
        setError(null)
        const res = await fetch(`/api/collections/${id}`, {
          signal: controller.signal,
          method: 'DELETE'
        })
        if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`)
        navigate('/collections')
      } catch (e) {
        if (e instanceof DOMException && e.name === 'AbortError') return
        setError(e instanceof Error ? e.message : String(e))
      }
  }

  const updateCollection = async () => {
    if (collectionName.trim() === '') return;

    const controller = new AbortController()
    try {
        setError(null)
        const res = await fetch(`/api/collections/${collection?.collectionId}`, { 
          signal: controller.signal,
          method: 'PUT',
          headers : {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            name: collectionName.trim()
          })
        })
        if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`)
        
        setCollectionName(collectionName)
        setOpenCollectionForm(false)
      } catch (e) {
        if (e instanceof DOMException && e.name === 'AbortError') return
        setError(e instanceof Error ? e.message : String(e))
      }
  }

  const removeVenueFromCollection = async (venueSeriesId: number, venueYear: number) => {
    const controller = new AbortController()

    try {
      setError(null)
      const res = await fetch(`/api/collections/${id}/venues`, {
        signal: controller.signal,
        method: 'DELETE',
        headers : {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          venueSeriesId: venueSeriesId,
          venueYear: venueYear
        })
      })
      if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`)
      setVenues(venues => venues.filter(venue => venue.seriesId !== venueSeriesId || venue.year !== venueYear))
    } catch (e) {
      if (e instanceof DOMException && e.name === 'AbortError') return
      setError(e instanceof Error ? e.message : String(e))
    }
  }

  return (
      <main className="main">
			<div className={style.returnLinkContainer}>
				<Link to='/collections' className={`${style.returnLink} muted`}><Icon path={mdiChevronLeft} size={1} />Collections</Link>
			</div>
			<header className={style.header}>
				<div className={style.headerContent}>
					<div>
						<p className={style.eyebrow}>My Collections</p>
						<h1 className={`${style.title} ${openCollectionForm ? 'hidden' : ''}`}>{collectionName || 'Collection'}</h1>
            <form className={`${style.collectionForm} ${openCollectionForm ? '' : 'hidden'}`} onSubmit={(e) => {
              e.preventDefault()
              updateCollection()
            }}>
              <input
                className={style.collectionNameInput}
                value={collectionName}
                onChange={(e) => setCollectionName(e.target.value)}
                placeholder="Collection name"
              />
              <button className={`pill ${style.updateButton}`}>Update</button>
            </form>
						
						<div className={style.metaRow}>
							<span className={style.metaItem}>
								Created by <strong>{collection?.creatorName || 'You'}</strong>
							</span>
							<span className={style.separator} aria-hidden="true">•</span>
							<span className={style.metaItem}>
								Created on {collection?.createdAt ? formatDate(collection.createdAt.toString()) : 'Date'}
							</span>
						</div>
					</div>
          <div className={style.modificationButtonsContainer}>
            <button className={`${style.modificationButton} ${openCollectionForm ? style.active : ''}`} onClick={() => setOpenCollectionForm(prevVal => !prevVal)}><Icon path={mdiSquareEditOutline} size={1} /></button>
            <button className={style.modificationButton} onClick={deleteCollection}><Icon path={mdiTrashCanOutline} size={1}/></button>
          </div>
				</div>
			</header>
      <section className={`card ${style.contentContainer}`}>
        <div className="cardHeader">
          <h2>Collection Venues</h2>
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
                  <th className={style.removeVenueButtonCellHeader}></th>
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
                      <tr
                          key={`${v.seriesId}-${v.year}`}
                          className={style.venueRow}
                          onClick={() => navigate(`/venue/${v.seriesId}/${v.year}`)}
                      >
                      <td className={style.removeVenueButtonCell}>
                        <button className={style.modificationButton} onClick={() => removeVenueFromCollection(v.seriesId, v.year)}>
                          <Icon path={mdiMinusCircleOutline} size={1}/>
                        </button>
                      </td>
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
