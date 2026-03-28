import './App.css'
import HomePage from './components/Home/HomePage';
import CollectionsPage from './components/Collections/CollectionsPage';
import NavBar from './components/NavBar';
import { Routes, Route } from 'react-router-dom';

export default function App() {
  return (
    <>
      <NavBar />
      <Routes>
        <Route index element={<HomePage />} />
        <Route path='/collections' element={<CollectionsPage />} />
      </Routes>
    </>
  );
}