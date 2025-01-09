import React, { useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { Lock } from 'lucide-react';

interface LocationState {
  message?: string;
}

export default function AdminLogin() {
  const [credentials, setCredentials] = useState({ user: { email: '', password: '' } });
  const [error, setError] = useState('');
  const navigate = useNavigate();
  const location = useLocation();
  const state = location.state as LocationState;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    try {
      const response = await fetch('http://localhost:3001/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: JSON.stringify({ user: { ...credentials.user } }),
      });

      const data = await response.json();

      if (response.ok) {
        const token = response.headers.get('Authorization');
        if (token) { localStorage.setItem('authToken', token.replace('Bearer ', '')); }
        navigate('/admin/dashboard');
      } else {
        setError(data.message || 'Authentication failed');
      }
    } catch (err) {
      setError('Network error. Please try again.');
    }
  };

  return (
    <div className="min-h-[calc(100vh-4rem)] flex items-center justify-center px-4">
      <div className="max-w-md w-full bg-white rounded-lg shadow-lg p-8">
        <div className="flex flex-col items-center mb-8">
          <Lock className="w-12 h-12 text-blue-600 mb-4" />
          <h2 className="text-2xl font-bold text-gray-900">Admin Login</h2>
        </div>

        {(state?.message || error) && (
          <div className="mb-4 p-3 bg-red-50 text-red-600 rounded-md text-sm">
            {state?.message || error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Email
            </label>
            <input
              type="email"
              value={credentials.user.email}
              onChange={(e) => setCredentials(prev => ({ ...prev, user: { ...prev.user, email: e.target.value } }))}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Password
            </label>
            <input
              type="password"
              value={credentials.user.password}
              onChange={(e) => setCredentials(prev => ({ ...prev, user: { ...prev.user, password: e.target.value } }))}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            />
          </div>

          <button
            type="submit"
            className="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 transition duration-200"
          >
            Login
          </button>
        </form>
      </div>
    </div>
  );
}
