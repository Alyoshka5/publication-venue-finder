import VenueListHeader from './VenueListHeader';
import VenueList from './VenueList';
import { useEffect, useState } from 'react'
import type { TopicOption } from '../../models/venues';
// Zoe addition 2026-04-03
import { useAuth } from '../Auth/useAuth';



export default function HomePage() {
  const [query, setQuery] = useState<string>('');
  const [selectedTopicId, setSelectedTopicId] = useState<string>('');
  const [topics, setTopics] = useState<TopicOption[]>([]);
  // Zoe
  const { currentUser } = useAuth();

  useEffect(() => {
    const controller = new AbortController();

    const run = async () => {
      try {
        const res = await fetch('/api/venues/topics', { signal: controller.signal });
        if (!res.ok) throw new Error(`API error: ${res.status} ${res.statusText}`);
        const data = (await res.json()) as TopicOption[];
        setTopics(Array.isArray(data) ? data : []);
      } catch (error) {
        if (error instanceof DOMException && error.name === 'AbortError') return;
        console.error('Failed to load topics', error);
      }
    };

    run();
    return () => controller.abort();
  }, []);

  return (
    <div className="page">
      <VenueListHeader
        query={query}
        setQuery={setQuery}
        topics={topics}
        selectedTopicId={selectedTopicId}
        setSelectedTopicId={setSelectedTopicId}
      />
      <VenueList query={query} selectedTopicId={selectedTopicId} userId={currentUser?.userId ?? null} />
    </div>
  )
}
