type OrganizationStat = {
  organization: string
  upcomingPostings: number
}

type UpcomingStats = {
  totalUpcomingPostings: number
  organizationStats: OrganizationStat[]
}

export type { OrganizationStat, UpcomingStats }
