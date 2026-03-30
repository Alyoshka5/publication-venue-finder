import style from './VenueListHeader.module.css';
import type { TopicOption } from '../../models/venues';

type VenueListHeaderProps = {
  query: string
  setQuery: React.Dispatch<React.SetStateAction<string>>
  topics: TopicOption[]
  selectedTopicId: string
  setSelectedTopicId: React.Dispatch<React.SetStateAction<string>>
}

export default function VenueListHeader({
  query,
  setQuery,
  topics,
  selectedTopicId,
  setSelectedTopicId
}: VenueListHeaderProps) {
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
          <label className={style.filter}>
            <span className={style.srOnly}>Topic</span>
            <select
              value={selectedTopicId}
              onChange={(e) => setSelectedTopicId(e.target.value)}
            >
              <option value="">All topics</option>
              {topics.map((topic) => (
                <option key={topic.topicId} value={String(topic.topicId)}>
                  {topic.name}
                </option>
              ))}
            </select>
          </label>
        </div>
      </header>
    );
}
