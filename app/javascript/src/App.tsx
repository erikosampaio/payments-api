import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Navbar from './components/Navbar';
import Welcome from './components/Welcome';
import { PaymentForm } from './components/PaymentForm';
import AdminLogin from './components/AdminLogin';
import AdminDashboard from './components/AdminDashboard';
import PaymentDetails from './components/PaymentDetails';

export default function App() {
  return (
    <BrowserRouter>
      <div className="min-h-screen bg-gray-50">
        <Navbar />
        <Routes>
          <Route path="/" element={<Welcome />} />
          <Route path="/payment" element={<PaymentForm />} />
          <Route path="/admin" element={<AdminLogin />} />
          <Route path="/admin/dashboard" element={<AdminDashboard />} />
          <Route path="/admin/payments/:id" element={<PaymentDetails />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
}
