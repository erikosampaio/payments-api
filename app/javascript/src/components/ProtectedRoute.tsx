import { Navigate, useNavigate } from 'react-router-dom';
import { useEffect } from 'react';

interface ProtectedRouteProps {
  children: React.ReactNode;
}

export default function ProtectedRoute({ children }: ProtectedRouteProps) {
  const navigate = useNavigate();
  const token = localStorage.getItem('authToken');

  useEffect(() => {
    const validateToken = async () => {
      try {
        const response = await fetch('http://localhost:3000/auth/validate', {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        });

        if (!response.ok) {
          localStorage.removeItem('authToken');
          navigate('/admin', { 
            state: { message: 'Session expired. Please login again.' }
          });
        }
      } catch (error) {
        localStorage.removeItem('authToken');
        navigate('/admin', { 
          state: { message: 'Authentication error. Please login again.' }
        });
      }
    };

    if (token) {
      validateToken();
    }
  }, [token, navigate]);

  if (!token) {
    return <Navigate to="/admin" state={{ message: 'Please login to access this page.' }} />;
  }

  return <>{children}</>;
}