import { Link } from 'react-router-dom'
import { useAuth } from '../Auth/useAuth'
import style from './ProfilePage.module.css'

const formatJoinedDate = (value: string) => {
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return value
  return date.toLocaleDateString(undefined, { year: 'numeric', month: 'long', day: 'numeric' })
}

export default function ProfilePage() {
  const { currentUser } = useAuth()

  return (
    <main className="main">
      <section className={style.shell}>
        <header className={style.header}>
          <p className={style.eyebrow}>User Profile</p>
          <h1 className={style.title}>Account Overview</h1>
          <p className={style.subtitle}>Profile, role, and account basics for the current signed-in user.</p>
        </header>

        {!currentUser ? (
          <section className={`card ${style.emptyCard}`}>
            <h2>No active session</h2>
            <p className={style.emptyText}>
              Sign in or create an account to unlock profile-based features like collections, bookmarks, and role-gated pages.
            </p>
            <div className={style.emptyActions}>
              <Link className={style.actionLink} to="/login">Log In</Link>
              <Link className={style.actionLinkSecondary} to="/signup">Create Account</Link>
            </div>
          </section>
        ) : (
          <section className={`card ${style.profileCard}`}>
            <div className={style.profileTop}>
              <div>
                <p className={style.profileName}>{currentUser.displayName}</p>
                <p className={style.profileEmail}>{currentUser.email}</p>
              </div>
              <span className={style.roleBadge}>{currentUser.role}</span>
            </div>

            <dl className={style.details}>
              <div>
                <dt>User ID</dt>
                <dd>{currentUser.userId}</dd>
              </div>
              <div>
                <dt>Joined</dt>
                <dd>{formatJoinedDate(currentUser.createdAt)}</dd>
              </div>
              <div>
                <dt>Role</dt>
                <dd>{currentUser.role}</dd>
              </div>
            </dl>
          </section>
        )}
      </section>
    </main>
  )
}
