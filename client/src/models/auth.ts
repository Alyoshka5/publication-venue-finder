type UserRole = 'researcher' | 'organizer' | 'admin'

type AuthUser = {
  userId: number
  email: string
  displayName: string
  createdAt: string
  role: UserRole
}

type AuthResponse = {
  user: AuthUser
}

export type { AuthResponse, AuthUser, UserRole }
