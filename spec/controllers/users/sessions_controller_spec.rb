require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:token) { JWT.encode({ sub: user.id }, Rails.application.credentials.devise_jwt_secret_key!) }

  describe '#respond_with/login' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context 'when login is successful' do
      before do
        post :create, params: { user: { email: user.email, password: user.password } }
      end

      it 'returns a successful login response' do
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['status']['message']).to eq('Logged in successfully.')
      end
    end

    context 'when login is unsuccessful' do
      before do
        post :create, params: { user: { email: user.email, password: 'invalid' } }
      end

      it 'returns an unauthorized response with an error message' do
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq('Invalid Email or password.')
      end
    end
  end

  describe '#respond_to_on_destroy/logout' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context 'when the user is logged in' do
      before do
        request.headers['Authorization'] = "Bearer #{token}"
      end

      it 'logs out successfully' do
        delete :destroy
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['message']).to eq('Logged out successfully.')
      end
    end

    context 'when the user is not logged in' do
      before do
        request.headers['Authorization'] = nil
      end

      it 'returns an unauthorized response' do
        delete :destroy
        expect(response).to have_http_status(:unauthorized)
        expect(response.parsed_body['message']).to eq("Couldn't find an active session.")
      end
    end

    context 'when the token is invalid' do
      before do
        invalid_token = JWT.encode({ user_id: user.id }, 'wrong_secret', 'HS256')
        request.headers['Authorization'] = "Bearer #{invalid_token}"
      end

      it 'returns an unauthorized response' do
        delete :destroy
        expect(response).to have_http_status(:unauthorized)
        expect(response.parsed_body['message']).to eq("Couldn't find an active session.")
      end
    end

    context 'when the token is expired' do
      before do
        expired_token = JWT.encode({ sub: user.id, exp: Time.now.to_i - 10 }, Rails.application.credentials.devise_jwt_secret_key!)
        request.headers['Authorization'] = "Bearer #{expired_token}"
      end

      it 'returns an unauthorized response' do
        delete :destroy
        expect(response).to have_http_status(:unauthorized)
        expect(response.parsed_body['message']).to eq("Couldn't find an active session.")
      end
    end
  end
end
