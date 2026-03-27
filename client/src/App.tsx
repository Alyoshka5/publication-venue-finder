import './App.css'
import HomePage from './components/Home/HomePage'
import NavBar from './components/NavBar';
import { Routes, Route } from 'react-router-dom';

export default function App() {
  return (
    <>
      <NavBar />
      <Routes>
        <Route index element={<HomePage />} />
      </Routes>
    </>
  );
}