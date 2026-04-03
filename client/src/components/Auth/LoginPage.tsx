import { useState } from 'react'
import { Link, Navigate, useNavigate } from 'react-router-dom'
import { useAuth } from './useAuth'
import type { AuthResponse } from '../../models/auth'
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

export default function LoginPage() {
  const navigate = useNavigate()
  const { currentUser, ready, signIn } = useAuth()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)

  if (ready && currentUser) {
    return <Navigate to={currentUser.role === 'admin' ? '/admin' : '/profile'} replace />
  }

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    try {
      setSubmitting(true)
      setError(null)

      const res = await fetch('/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password })
      })

      const data = await readApiResponse(res)
      if (!res.ok || !('user' in data)) {
        const message = 'error' in data ? data.error : undefined
        throw new Error(message ?? 'Login failed')
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
          <p className={style.eyebrow}>Account Access</p>
          <h1 className={style.title}>Log In</h1>
          <p className={style.subtitle}>Use an existing Publication Venue Finder account to unlock profile and role-based pages.</p>
        </header>

        <section className={`card ${style.formCard}`}>
          <form className={style.form} onSubmit={handleSubmit}>
            <label className={style.field}>
              <span>Email</span>
              <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} required />
            </label>
            <label className={style.field}>
              <span>Password</span>
              <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
            </label>

            {error ? <div className={style.error}>{error}</div> : null}

            <button className={style.submitButton} type="submit" disabled={submitting}>
              {submitting ? 'Logging in…' : 'Log In'}
            </button>
          </form>

          <p className={style.helper}>
            Need an account? <Link to="/signup">Create one here</Link>.
          </p>
        </section>
      </section>
    </main>
  )
}
