import React from 'react';
import { useParams } from 'react-router-dom';
import { CreditCard, Calendar, User, DollarSign } from 'lucide-react';

export default function PaymentDetails() {
  const { id } = useParams();
  const [payment, setPayment] = React.useState<any>(null);

  React.useEffect(() => {
    // Replace with actual API call
    setPayment(SAMPLE_PAYMENTS.find(p => p.id === Number(id)));
  }, [id]);

  if (!payment) {
    return <div>Loading...</div>;
  }

  return (
    <div className="max-w-3xl mx-auto px-4 py-8">
      <div className="bg-white rounded-lg shadow-lg p-6">
        <h2 className="text-2xl font-bold text-gray-900 mb-6">Payment Details</h2>
        
        <div className="grid gap-6">
          <div className="flex items-center p-4 bg-gray-50 rounded-lg">
            <User className="h-6 w-6 text-blue-600 mr-3" />
            <div>
              <p className="text-sm text-gray-500">Customer Name</p>
              <p className="text-lg font-medium">{payment.customerName}</p>
            </div>
          </div>

          <div className="flex items-center p-4 bg-gray-50 rounded-lg">
            <CreditCard className="h-6 w-6 text-blue-600 mr-3" />
            <div>
              <p className="text-sm text-gray-500">Card Number</p>
              <p className="text-lg font-medium">**** **** **** {payment.cardLastFour}</p>
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
            <Calendar className="h-6 w-6 text-blue-600 mr-3" />
            <div>
              <p className="text-sm text-gray-500">Date</p>
              <p className="text-lg font-medium">{payment.date}</p>
            </div>
          </div>

          <div className="flex items-center p-4 bg-gray-50 rounded-lg">
            <div>
              <p className="text-sm text-gray-500">Status</p>
              <span className={`px-3 py-1 inline-flex text-sm font-semibold rounded-full
                ${payment.status === 'completed' 
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