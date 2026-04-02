import { createContext, useEffect, useState } from 'react'
import type { AuthUser } from '../../models/auth'

const STORAGE_KEY = 'pvf.currentUser'

type AuthContextValue = {
  currentUser: AuthUser | null
  ready: boolean
  signIn: (user: AuthUser) => void
  signOut: () => void
}

const AuthContext = createContext<AuthContextValue | null>(null)

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [currentUser, setCurrentUser] = useState<AuthUser | null>(null)
  const [ready, setReady] = useState(false)

  useEffect(() => {
    try {
      const storedValue = localStorage.getItem(STORAGE_KEY)
      if (storedValue) {
        setCurrentUser(JSON.parse(storedValue) as AuthUser)
      }
    } catch (error) {
      console.error('Failed to restore auth session', error)
      localStorage.removeItem(STORAGE_KEY)
    } finally {
      setReady(true)
    }
  }, [])

  const signIn = (user: AuthUser) => {
    setCurrentUser(user)
    localStorage.setItem(STORAGE_KEY, JSON.stringify(user))
  }

  const signOut = () => {
    setCurrentUser(null)
    localStorage.removeItem(STORAGE_KEY)
  }

  return (
    <AuthContext.Provider value={{ currentUser, ready, signIn, signOut }}>
      {children}
    </AuthContext.Provider>
  )
}

export { AuthContext }
export type { AuthContextValue }
