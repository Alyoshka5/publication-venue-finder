import style from './VenueListHeader.module.css';

export default function VenueListHeader({ query, setQuery }: { query: string, setQuery: React.Dispatch<React.SetStateAction<string>> }) {
    return (
        <header className={style.header}>
        <div className={style.brand}>
          <div className={style.mark} aria-hidden="true">
            PVF
          </div>
          <div className={style.brandText}>
            <h1>Publication Venue Finder</h1>
            <p className={style.subtitle}>Upcoming venues (from MySQL via Express)</p>
          </div>
        </div>
        <div className={style.headerRight}>
          <label className={style.search}>
            <span className={style.srOnly}>Search</span>
            <input
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="Search acronym, title, org, location, year…"
            />
          </label>
        </div>
      </header>
    );
}