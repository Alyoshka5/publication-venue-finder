import { NavLink } from 'react-router-dom';
import style from './NavBar.module.css';

export default function NavBar() {
    return (
      <aside className={style.sideNav} aria-label="Main navigation">
        <div className={style.navContent}>
          <section className={style.navSection}>
            <NavLink
              to='/'
              end
              className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
            >Find Venues</NavLink>
            <NavLink
              to='/admin'
              className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
            >Admin Dashboard</NavLink>
            <NavLink
              to='/collections'
              className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
            >My Collections</NavLink>
            <NavLink
              to='/profile'
              className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
            >Profile</NavLink>
          </section>
          <section className={style.navSection}>
            <NavLink
              to='/logout'
              className={({ isActive }) => `${style.navItem} ${isActive ? style.active : ''}`}
            >Log Out</NavLink>
          </section>
        </div>
      </aside>
    );
}
