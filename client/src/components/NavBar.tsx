import { NavLink, useNavigate } from 'react-router-dom';
import { useAuth } from './Auth/useAuth';
import style from './NavBar.module.css';

export default function NavBar() {
    const { currentUser, ready, signOut } = useAuth();
    const navigate = useNavigate();

    const handleSignOut = () => {
      signOut();
      navigate('/');
    };

    return (
      <aside className={style.sideNav} aria-label="Main navigation">
        <div className={style.navContent}>
          <section className={style.navSection}>
            <NavLink
              to='/'
              end
              className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
            >Find Venues</NavLink>
            {ready && currentUser?.role === 'admin' ? (
              <>
                <NavLink
                  to='/admin'
                  end
                  className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
                >Admin Dashboard</NavLink>
                <NavLink
                  to='/admin/review'
                  className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
                >Review Requests</NavLink>
              </>
            ) : null}
            {ready && currentUser?.role === 'organizer' ? (
              <NavLink
                to='/organizer/submit'
                className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
              >Submit Venue</NavLink>
            ) : null}
            {ready && currentUser?.role === 'researcher' ? (
              <NavLink
                to='/collections'
                className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
              >My Collections</NavLink>
            ) : null}
            {ready && currentUser ? (
              <>
                <NavLink
                  to='/profile'
                  className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
                >Profile</NavLink>
              </>
            ) : (
              <>
                <NavLink
                  to='/login'
                  className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
                >Log In</NavLink>
                <NavLink
                  to='/signup'
                  className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
                >Create Account</NavLink>
              </>
            )}
          </section>
          {ready && currentUser ? (
            <section className={style.navSection}>
              <button type="button" className={style.navButton} onClick={handleSignOut}>Log Out</button>
            </section>
          ) : null}
        </div>
      </aside>
    );
}
