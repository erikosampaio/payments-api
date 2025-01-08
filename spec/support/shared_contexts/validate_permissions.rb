require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.shared_context 'when validate permissions' do
  include Devise::Test::IntegrationHelpers

  let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)[0] }

  before do
    request.headers['Authorization'] = "Bearer #{jwt_token}"
    request.headers['Content-Type'] = 'application/json'
    request.headers['Accept'] = 'application/json'
  end

  context 'when user is authenticated' do
    before do
      get :index
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when user is not authenticated' do
    before do
      request.headers['Authorization'] = nil
      get :index
    end

    it 'returns an unauthorized response' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
