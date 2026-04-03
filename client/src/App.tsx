import './App.css'
import HomePage from './components/Home/HomePage'
import AdminDashboard from './components/Admin/AdminDashboard'
import LoginPage from './components/Auth/LoginPage'
import SignupPage from './components/Auth/SignupPage'
import NavBar from './components/NavBar';
import ProfilePage from './components/Profile/ProfilePage'
import { Routes, Route } from 'react-router-dom';

export default function App() {
  return (
    <>
      <NavBar />
      <Routes>
        <Route index element={<HomePage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/signup" element={<SignupPage />} />
        <Route path="/profile" element={<ProfilePage />} />
        <Route path="/admin" element={<AdminDashboard />} />
      </Routes>
    </>
  );
}
