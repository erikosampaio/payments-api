import { Link } from 'react-router-dom';
import { CreditCard, ShieldCheck } from 'lucide-react';

export default function Welcome() {
  return (
    <div className="max-w-7xl mx-auto px-4 py-12">
      <div className="text-center">
        <h1 className="text-4xl font-bold text-gray-900 mb-8">
          Welcome to PaySystem
        </h1>
        <p className="text-xl text-gray-600 mb-12">
          Choose your destination below
        </p>

        <div className="grid md:grid-cols-2 gap-8 max-w-4xl mx-auto">
          <Link
            to="/payment"
            className="p-6 bg-white rounded-lg shadow-lg hover:shadow-xl transition-shadow duration-300"
          >
            <div className="flex flex-col items-center">
              <CreditCard className="h-12 w-12 text-blue-600 mb-4" />
              <h2 className="text-2xl font-semibold text-gray-900 mb-2">
                Make a Payment
              </h2>
              <p className="text-gray-600 text-center">
                Process your payment securely with our payment system
              </p>
            </div>
          </Link>

          <Link
            to={ localStorage.getItem('authToken') ? '/admin/dashboard' : '/admin' }
            className="p-6 bg-white rounded-lg shadow-lg hover:shadow-xl transition-shadow duration-300"
          >
            <div className="flex flex-col items-center">
              <ShieldCheck className="h-12 w-12 text-blue-600 mb-4" />
              <h2 className="text-2xl font-semibold text-gray-900 mb-2">
                Admin Area
              </h2>
              <p className="text-gray-600 text-center">
                Access the admin dashboard to manage payments
              </p>
            </div>
          </Link>
        </div>
      </div>
    </div>
  );
}