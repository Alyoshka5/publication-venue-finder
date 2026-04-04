import { useState } from 'react'
import { Link, Navigate, useNavigate } from 'react-router-dom'
import { useAuth } from './useAuth'
import type { AuthResponse, UserRole } from '../../models/auth'
import style from './AuthPage.module.css'

const readApiResponse = async (res: Response) => {
  const contentType = res.headers.get('content-type') ?? ''

  if (contentType.includes('application/json')) {
    return (await res.json()) as AuthResponse | { error?: string; details?: string }
  }

  const text = await res.text()
  throw new Error(
    text.includes('<!DOCTYPE')
      ? 'The auth API did not return JSON. Make sure the server is running and restart it after adding new routes.'
      : text || 'The auth API returned an unexpected response.'
  )
}

export default function SignupPage() {
  const navigate = useNavigate()
  const { currentUser, ready, signIn } = useAuth()
  const [displayName, setDisplayName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [role, setRole] = useState<UserRole>('researcher')
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)

  if (ready && currentUser) {
    return <Navigate to={currentUser.role === 'admin' ? '/admin' : '/profile'} replace />
  }

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    if (password !== confirmPassword) {
      setError('password and confirm password must match')
      return
    }

    try {
      setSubmitting(true)
      setError(null)

      const res = await fetch('/api/auth/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ displayName, email, password, role })
      })

      const data = await readApiResponse(res)
      if (!res.ok || !('user' in data)) {
        const message = 'error' in data ? data.error : undefined
        throw new Error(message ?? 'Registration failed')
      }

      signIn(data.user)
      navigate(data.user.role === 'admin' ? '/admin' : '/profile')
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e))
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <main className="main">
      <section className={style.shell}>
        <header className={style.header}>
          <p className={style.eyebrow}>Account Setup</p>
          <h1 className={style.title}>Create Account</h1>
          <p className={style.subtitle}>This scaffold creates a user in the existing schema and assigns a project role for demo purposes.</p>
        </header>

        <section className={`card ${style.formCard}`}>
          <form className={style.form} onSubmit={handleSubmit}>
            <label className={style.field}>
              <span>Display name</span>
              <input value={displayName} onChange={(e) => setDisplayName(e.target.value)} required />
            </label>
            <label className={style.field}>
              <span>Email</span>
              <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} required />
            </label>
            <label className={style.field}>
              <span>Password</span>
              <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} minLength={8} required />
            </label>
            <label className={style.field}>
              <span>Confirm password</span>
              <input type="password" value={confirmPassword} onChange={(e) => setConfirmPassword(e.target.value)} minLength={8} required />
            </label>
            <label className={style.field}>
              <span>Role</span>
              <select value={role} onChange={(e) => setRole(e.target.value as UserRole)}>
                <option value="researcher">Researcher</option>
                <option value="organizer">Organizer</option>
                <option value="admin">Admin</option>
              </select>
            </label>

            {error ? <div className={style.error}>{error}</div> : null}

            <button className={style.submitButton} type="submit" disabled={submitting}>
              {submitting ? 'Creating account…' : 'Create Account'}
            </button>
          </form>

          <p className={style.helper}>
            Already have an account? <Link to="/login">Log in instead</Link>.
          </p>
        </section>
      </section>
    </main>
  )
}
