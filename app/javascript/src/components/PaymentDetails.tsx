import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { ChevronLeft, CreditCard, User, DollarSign } from 'lucide-react';

interface Payment {
  name: string;
  number: string;
  amount: number;
  status: string;
}

export default function PaymentDetails() {
  const [payment, setPayment] = useState<Payment | null>(null);
  const [error, setError] = useState<string>('');
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();

  useEffect(() => {
    const fetchPayment = async () => {
      if (!id) return;

      if (!localStorage.getItem('authToken')) {
        navigate('/admin');
        return null;
      }

      try {
        const response = await fetch(`http://localhost:3001/api/v1/payments/${id}`, {
          method: 'GET',
          headers: {
            'Authorization': `Bearer ${localStorage.getItem('authToken')}`,
            'Content-Type': 'application/json',
          },
        });

        if (response.ok) {
          const data = await response.json();
          setPayment(data.data);
        } else {
          setError('Failed to load payment details');
        }
      } catch (err) {
        setError('Network error. Please try again.');
      }
    };

    fetchPayment();
  }, [id]);

  if (!payment) {
    return <div>Loading...</div>;
  }

  return (
    <div className="max-w-3xl mx-auto px-4 py-8">
      <div className="bg-white rounded-lg shadow-lg p-6">
        <div className="flex items-center mb-6">
          <ChevronLeft 
            className="h-6 w-6 text-gray-600 cursor-pointer"
            onClick={() => navigate('/admin/dashboard')} 
          />
          <h2 className="text-2xl font-bold text-gray-900 ml-4">Payment Details</h2>
        </div>

        {error && <p className="text-red-500 mb-4">{error}</p>}

        <div className="grid gap-6">
          <div className="flex items-center p-4 bg-gray-50 rounded-lg">
            <User className="h-6 w-6 text-blue-600 mr-3" />
            <div>
              <p className="text-sm text-gray-500">Customer Name</p>
              <p className="text-lg font-medium">{payment.name}</p>
            </div>
          </div>

          <div className="flex items-center p-4 bg-gray-50 rounded-lg">
            <CreditCard className="h-6 w-6 text-blue-600 mr-3" />
            <div>
              <p className="text-sm text-gray-500">Card Number</p>
              <p className="text-lg font-medium">{payment.number}</p>
            </div>
          </div>

          <div className="flex items-center p-4 bg-gray-50 rounded-lg">
            <DollarSign className="h-6 w-6 text-blue-600 mr-3" />
            <div>
              <p className="text-sm text-gray-500">Amount</p>
              <p className="text-lg font-medium">${payment.amount}</p>
            </div>
          </div>

          <div className="flex items-center p-4 bg-gray-50 rounded-lg">
            <div>
              <p className="text-sm text-gray-500">Status</p>
              <span
                className={`px-3 py-1 inline-flex text-sm font-semibold rounded-full
                  ${payment.status === 'paid'
                    ? 'bg-green-100 text-green-800'
                    : 'bg-yellow-100 text-yellow-800'
                }`}
              >
                {payment.status}
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
