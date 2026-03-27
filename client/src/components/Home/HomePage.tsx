import VenueListHeader from './VenueListHeader';
import VenueList from './VenueList';
import { useState } from 'react'


export default function HomePage() {
  const [query, setQuery] = useState<string>('');

  return (
    <div className="page">
      <VenueListHeader query={query} setQuery={setQuery}  />
      <VenueList query={query} />
    </div>
  )
}