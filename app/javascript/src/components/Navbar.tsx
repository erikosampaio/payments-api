import { Link, useLocation } from 'react-router-dom';
import { CreditCard, ShieldCheck, User } from 'lucide-react';

export default function Navbar() {
  const location = useLocation();

  const handleLogout = () => {
    localStorage.removeItem('authToken');
    window.location.href = '/';
  };

  return (
    <nav className="bg-white shadow-lg">
      <div className="max-w-7xl mx-auto px-4">
        <div className="flex justify-between h-16">
          <div className="flex">
            <Link to="/" className="flex items-center">
              <CreditCard className="h-6 w-6 text-blue-600" />
              <span className="ml-2 font-semibold text-xl">PaySystem</span>
            </Link>
          </div>

          <div className="flex space-x-4">
            <Link
              to="/payment"
              className={`inline-flex items-center px-3 py-2 rounded-md text-sm font-medium
                ${location.pathname === '/payment' 
                  ? 'text-blue-600 bg-blue-50' 
                  : 'text-gray-700 hover:text-blue-600 hover:bg-blue-50'
                }`}
            >
              <CreditCard className="h-4 w-4 mr-1" />
              Payment
            </Link>

            {localStorage.getItem('authToken') ? (
              <button
                onClick={handleLogout}
                className="inline-flex items-center px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:text-blue-600 hover:bg-blue-50"
              >
                <User className="h-4 w-4 mr-1" />
                Logout
              </button>
            ) : (
              <Link
              to="/admin"
              className={`inline-flex items-center px-3 py-2 rounded-md text-sm font-medium
                ${location.pathname.startsWith('/admin') 
                  ? 'text-blue-600 bg-blue-50' 
                  : 'text-gray-700 hover:text-blue-600 hover:bg-blue-50'
                }`}
              >
                <ShieldCheck className="h-4 w-4 mr-1" />
                Admin Area
              </Link>
            )}
          </div>
        </div>
      </div>
    </nav>
  );
}