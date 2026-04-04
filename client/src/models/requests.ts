type OrganizationOption = {
  orgId: number
  name: string
  website: string
}

type ConferenceSeriesOption = {
  seriesId: number
  orgId: number
  organization: string
  name: string
  acronym: string | null
}

type VenueRequestPayload = {
  existingSeriesId: number | null
  existingOrgId: number | null
  newOrganizationName: string
  newOrganizationWebsite: string
  newOrganizationSociety: string
  newOrganizationPublisher: string
  newOrganizationUniversity: string
  newSeriesName: string
  newSeriesAcronym: string
  newSeriesDescription: string
  typicalMonth: number | null
  typicalCityPolicy: string
  tier: string
  year: number
  title: string
  startDate: string | null
  endDate: string | null
  city: string
  country: string
  submissionDeadline: string | null
  cfpUrl: string
  callForPapers: string
}

type RequestMetaResponse = {
  organizations: OrganizationOption[]
  conferenceSeries: ConferenceSeriesOption[]
  usedYearsBySeries: {
    seriesId: number
    years: number[]
  }[]
}

type VenueRequestRecord = {
  requestId: number
  submittedByUserId: number
  submittedByName: string
  reviewedByUserId: number | null
  reviewedByName: string | null
  createdAt: string
  status: 'pending' | 'approved' | 'rejected'
  requestType: string | null
  payload: VenueRequestPayload
}

type AdminRequestsResponse = {
  requests: VenueRequestRecord[]
}

export type {
  AdminRequestsResponse,
  ConferenceSeriesOption,
  OrganizationOption,
  RequestMetaResponse,
  VenueRequestPayload,
  VenueRequestRecord
}
