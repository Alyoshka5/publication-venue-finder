export const formatDate = (value: string | null) => {
  if (!value) return '—'
  const d = new Date(value)
  if (Number.isNaN(d.getTime())) return value
  return d.toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: '2-digit' })
}

export const formatLocation = (city: string, country: string) => {
  if (!city && !country) return '—'
  if (!city) return country
  if (!country) return city
  return `${city}, ${country}`
}