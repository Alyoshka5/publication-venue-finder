import { useState } from 'react';
import { Link } from 'react-router-dom';
import style from './NavBar.module.css';

export default function NavBar() {
    const [activeTab, setActiveTab] = useState<string>('home');

    return (
      <aside className={style.sideNav} aria-label="Main navigation">
        <div className={style.navContent}>
          <section className={style.navSection}>
            <Link 
              to='/'
              className={`${style.navItem} ${activeTab === 'home' ? style.active : ''}`}
              onClick={() => setActiveTab('home')}
            >Find Venues</Link>
            <Link 
              to='/collections'
              className={`${style.navItem} ${activeTab === 'collections' ? style.active : ''}`}
              onClick={() => setActiveTab('collections')}
            >My Collections</Link>
            <Link 
              to='/profile'
              className={`${style.navItem} ${activeTab === 'profile' ? style.active : ''}`}
              onClick={() => setActiveTab('profile')}
            >Profile</Link>
          </section>
          <section className={style.navSection}>
            <Link 
              to='/logout'
              className={`${style.navItem} ${activeTab === 'logout' ? style.active : ''}`}
              onClick={() => setActiveTab('logout')}
            >Log Out</Link>
          </section>
        </div>
      </aside>
    );
}