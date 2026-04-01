type Venue = {
  seriesId: number
  acronym: string | null
  year: number
  title: string
  city: string
  country: string
  submissionDeadline: string | null
  organization: string
  topics: string | null
}

type TopicOption = {
  topicId: number
  name: string
}

export type { Venue, TopicOption }
