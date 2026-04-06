import './App.css'
import HomePage from './components/Home/HomePage';
import CollectionsPage from './components/Collections/CollectionsPage';
import AdminDashboard from './components/Admin/AdminDashboard'
import LoginPage from './components/Auth/LoginPage'
import SignupPage from './components/Auth/SignupPage'
import NavBar from './components/NavBar';
import ProfilePage from './components/Profile/ProfilePage'
import { Routes, Route } from 'react-router-dom';
import CollectionDetails from './components/Collections/CollectionDetails';
import CollectionList from './components/Collections/CollectionList';
import OrganizerSubmissionPage from './components/Organizer/OrganizerSubmissionPage';
import AdminReviewPage from './components/Admin/AdminReviewPage';
import VenueDetail from './components/Home/VenueDetail';

export default function App() {
  return (
    <>
      <NavBar />
      <Routes>
        <Route index element={<HomePage />} />
        <Route path='/collections' element={<CollectionsPage />}>
          <Route index element={<CollectionList />} />
          <Route path=':id' element={<CollectionDetails />} />
        </Route>
        <Route path="/login" element={<LoginPage />} />
        <Route path="/signup" element={<SignupPage />} />
        <Route path="/profile" element={<ProfilePage />} />
        <Route path="/admin" element={<AdminDashboard />} />
        <Route path="/admin/review" element={<AdminReviewPage />} />
        <Route path="/organizer/submit" element={<OrganizerSubmissionPage />} />
        <Route path="/venue/:seriesId/:year" element={<VenueDetail />} />
      </Routes>
    </>
  );
}
