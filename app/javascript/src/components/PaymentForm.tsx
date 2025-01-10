import React, { useState } from 'react';
import { CreditCard } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

interface PaymentFormData {
  name: string;
  number: string;
  due_date: string;
  cvc: string;
  amount: number;
}

const SAMPLE_PRODUCT = {
  name: "Premium Subscription",
  price: 99.99
};

export function PaymentForm() {
  const [formData, setFormData] = useState<PaymentFormData>({
    name: '',
    number: '',
    due_date: '',
    cvc: '',
    amount: SAMPLE_PRODUCT.price
  });

  const [error, setError] = useState<string>('');
  const [successMessage, setSuccessMessage] = useState<string>('');
  const navigate = useNavigate();

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/api/v1/payments`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          name: formData.name,
          number: formData.number,
          due_date: formData.due_date,
          cvc: formData.cvc,
          amount: SAMPLE_PRODUCT.price
        }),
      });

      if (response.ok) {
        const data = await response.json();
        setSuccessMessage(data.message || 'Payment created successfully!');
        setFormData({ name: '', number: '', due_date: '', cvc: '', amount: SAMPLE_PRODUCT.price });
        setTimeout(() => {
          navigate('/');
        }, 1500);
      } else {
        const data = await response.json();
        setError(data.message || 'Failed to create payment.');
      }
    } catch (err) {
      setError('Network error. Please try again.');
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col items-center justify-center p-4">
      <div className="max-w-md w-full bg-white rounded-lg shadow-lg p-8">
        <div className="flex items-center justify-center mb-8">
          <CreditCard className="w-8 h-8 text-blue-600 mr-2" />
          <h2 className="text-2xl font-bold text-gray-800">Payment Details</h2>
        </div>

        <div className="mb-6 p-4 bg-gray-50 rounded-lg">
          <h3 className="text-lg font-semibold text-gray-800">{SAMPLE_PRODUCT.name}</h3>
          <p className="text-2xl font-bold text-blue-600">${SAMPLE_PRODUCT.price}</p>
        </div>

        {successMessage && (
          <div className="mb-4 p-4 bg-green-100 text-green-800 rounded-md">
            {successMessage}
          </div>
        )}
        {error && (
          <div className="mb-4 p-4 bg-red-100 text-red-800 rounded-md">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Cardholder Name
            </label>
            <input
              type="text"
              name="name"
              value={formData.name}
              onChange={handleInputChange}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Card Number
            </label>
            <input
              type="text"
              name="number"
              value={formData.number}
              onChange={handleInputChange}
              maxLength={16}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Expiry Date
              </label>
              <input
                type="text"
                name="due_date"
                value={formData.due_date}
                onChange={handleInputChange}
                placeholder="MM-YY"
                maxLength={5}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                cvc
              </label>
              <input
                type="text"
                name="cvc"
                value={formData.cvc}
                onChange={handleInputChange}
                maxLength={3}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
          </div>

          <button
            type="submit"
            className="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 transition duration-200"
          >
            Pay ${SAMPLE_PRODUCT.price}
          </button>
        </form>
      </div>
    </div>
  );
}
