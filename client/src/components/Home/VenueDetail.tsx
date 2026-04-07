import { useEffect, useState, useRef } from 'react';
import { useParams, Link } from 'react-router-dom';
import style from './VenueDetail.module.css';
import { useAuth } from '../Auth/useAuth';
import { formatDate, formatLocation } from '../../helpers/formatting';
import type { Collection } from '../../models/collections';

// Define a proper type for the venue
interface VenueDetailType {
    seriesId: number;
    seriesName: string;
    acronym: string;
    description?: string;
    year: number;
    title: string;
    city: string;
    country: string;
    startDate?: string;
    endDate?: string;
    submissionDeadline?: string;
    cfpUrl?: string;
    callForPapers?: string;
    organization: string;
    website?: string;
    society?: string;
    publisher?: string;
    university?: string;
    tier?: string;
    typicalMonth?: number;
}

export default function VenueDetail() {
    const { seriesId, year } = useParams<{ seriesId: string; year: string }>();
    const [venue, setVenue] = useState<VenueDetailType | null>(null);
    const [bookmarked, setBookmarked] = useState(false);
    const { currentUser } = useAuth();
    const userId = currentUser?.userId ?? null;
    const [collections, setCollections] = useState<Collection[]>([]);
    const [collectedIds, setCollectedIds] = useState<number[]>([]);
    const [dropdownOpen, setDropdownOpen] = useState(false);
    const dropdownRef = useRef<HTMLDivElement>(null);
    

    useEffect(() => {
        fetch(`/api/venues/${seriesId}/${year}`)
            .then(res => res.json())
            .then((data: VenueDetailType) => setVenue(data));
    }, [seriesId, year]);

    useEffect(() => {
        if (!venue || !userId) return;

        const checkBookmark = async () => {
            const res = await fetch(
                `/api/bookmarks/${userId}/${venue.seriesId}/${venue.year}`
            );
            const data = await res.json();
            setBookmarked(data.bookmarked);
        };

        checkBookmark();
    }, [venue, userId]);

    /* fetch collections */
    useEffect(() => {
        if (!userId) return;

        const fetchCollections = async () => {
            try {
                const res = await fetch(`/api/collections/user/${userId}`);
                if (!res.ok) throw new Error('Failed to fetch collections');
                const data = await res.json();
                setCollections(Array.isArray(data) ? data : []);
            } catch (err) {
                console.error(err);
            }
        };

        fetchCollections();
    }, [userId]);

    /* fetch which collections contain this venue */
    useEffect(() => {
        if (!userId || !venue) return;

        const fetchCollected = async () => {
            try {
                const res = await fetch(
                    `/api/collections/${userId}/${venue.seriesId}/${venue.year}`
                );
                const data = await res.json();
                setCollectedIds(Array.isArray(data) ? data : []);
            } catch (err) {
                console.error(err);
            }
        };

        fetchCollected();
    }, [userId, venue]);

    /* click outside to remove dropdown box */
    useEffect(() => {
        const handleClickOutside = (event: MouseEvent) => {
            if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
                setDropdownOpen(false);
            }
        };

        document.addEventListener('mousedown', handleClickOutside);
        return () => {
            document.removeEventListener('mousedown', handleClickOutside);
        };
    }, []);

    if (!venue) return <div>Loading...</div>;

    const handleBookmark = async () => {
        if (bookmarked || !userId) return;

        await fetch('/api/bookmarks', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                userId,
                seriesId: venue.seriesId,
                year: venue.year
            })
        });

        setBookmarked(true);
    };

    const handleAddToCollection = async (collection: Collection) => {
        if (!userId || !venue) return;

        // prevent duplicate add only for that specific collection
        if (collectedIds.includes(collection.collectionId)) return;

        await fetch('/api/collections', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                userId,
                collectionId: collection.collectionId,
                seriesId: venue.seriesId,
                year: venue.year
            })
        });

        setCollectedIds((prev) => [...prev, collection.collectionId]);
        setDropdownOpen(false);
    };

    return (
        <div className={style.container}>

            <div className={style.cardsContainer}>
                {/* Left Card */}
                <div className={style.card}>
                    <h1 className={style.title}>{venue.title}</h1>

                    <div className={style.section}>
                        <span className={style.label}>Acronym:</span>
                        <span className={style.value}>{venue.acronym}</span>
                    </div>

                    <div className={style.section}>
                        <span className={style.label}>Series:</span>
                        <span className={style.value}>{venue.seriesName}</span>
                    </div>

                    <div className={style.section}>
                        <span className={style.label}>Year:</span>
                        <span className={style.value}>{venue.year}</span>
                    </div>

                    <div className={style.section}>
                        <span className={style.label}>Location:</span>
                        <span className={style.value}>
                            {formatLocation(venue.city, venue.country)}
                        </span>
                    </div>

                    {(venue.startDate && venue.endDate) && (
                        <div className={style.section}>
                            <span className={style.label}>Dates:</span>
                            <span className={style.value}>
                                {formatDate(venue.startDate)} → {formatDate(venue.endDate)}
                            </span>
                        </div>
                    )}

                    {venue.submissionDeadline && (
                        <div className={style.section}>
                            <span className={style.label}>Deadline:</span>
                            <span className={style.value}>
                                {formatDate(venue.submissionDeadline)}
                            </span>
                        </div>
                    )}

                    <div className={style.buttons}>
                        {/* Bookmark button */}
                        <button
                            className={style.bookmarkButton}
                            onClick={handleBookmark}
                            disabled={bookmarked || !userId}
                        >
                            {!userId ? 'Log in to bookmark' : bookmarked ? 'Bookmarked' : 'Bookmark'}
                        </button>

                        {/* Collection button */}
                        <div className={style.dropdownContainer} ref={dropdownRef}>
                            <button
                                className={style.collectionButton}
                                onClick={() => setDropdownOpen(prev => !prev)}
                                disabled={!userId}
                            >
                                {!userId ? 'Log in to collect' : 'Add to Collection'}
                                <span className={style.arrow}>
                                    {dropdownOpen ? '▲' : '▼'}
                                </span>
                            </button>

                            {/* Dropdown contents */}
                            {dropdownOpen && (
                                <div className={style.dropdownMenu}>
                                    {collections.length === 0 ? (
                                        <div className={style.dropdownItem}>No collections</div>
                                    ) : (
                                        collections.map(c => {
                                            const added = collectedIds.includes(c.collectionId);

                                            return (
                                                <div
                                                    key={c.collectionId}
                                                    className={`${style.dropdownItem} ${added ? style.selectedItem : ''}`}
                                                    onClick={() => !added && handleAddToCollection(c)} /* won't let you add dup */
                                                >
                                                    {c.name}
                                                </div>
                                            );
                                        })
                                    )}
                                </div>
                            )}
                        </div>
                    </div>
                </div>

                {/* Right Card */}
                <div className={style.card}>
                    <div className={style.cardContent}>
                        {venue.description && (
                            <div className={style.section}>
                                <span className={style.label}>Description:</span>
                                <span className={style.value}>{venue.description}</span>
                            </div>
                        )}

                        <div className={style.section}>
                            <span className={style.label}>Organization:</span>
                            <span className={style.value}>{venue.organization}</span>
                        </div>

                        {venue.website && (
                            <div className={style.section}>
                                <span className={style.label}>Website:</span>
                                <a href={venue.website} target="_blank" rel="noreferrer">{venue.website}</a>
                            </div>
                        )}

                        {venue.publisher && (
                            <div className={style.section}>
                                <span className={style.label}>Publisher:</span>
                                <span className={style.value}>{venue.publisher}</span>
                            </div>
                        )}

                        {venue.tier && (
                            <div className={style.section}>
                                <span className={style.label}>Tier:</span>
                                <span className={style.value}>{venue.tier}</span>
                            </div>
                        )}

                        {venue.typicalMonth && (
                            <div className={style.section}>
                                <span className={style.label}>Typical Month:</span>
                                <span className={style.value}>{venue.typicalMonth}</span>
                            </div>
                        )}

                        {venue.cfpUrl && (
                            <div className={style.section}>
                                <span className={style.label}>CFP:</span>
                                <a href={venue.cfpUrl} target="_blank" rel="noreferrer">View Call for Papers</a>
                            </div>
                        )}
                    </div>
                </div>
            </div>

            <div className={style.backButtonContainer}>
                <Link to="/" className={style.backButton}>← Back</Link>
            </div>
        </div>
    );
}
