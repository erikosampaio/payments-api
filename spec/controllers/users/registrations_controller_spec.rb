require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:valid_user_attributes) { attributes_for(:user) }
  let(:invalid_user_attributes) { { email: '', password: '' } }

  describe '#respond_with' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context 'when signup is successful' do
      it 'returns a successful signup response' do
        post :create, params: { user: valid_user_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['status']['message']).to eq('Signed up successfully.')
        expect(response.parsed_body['data']).to have_key('email')
      end
    end

    context 'when signup fails' do
      it 'returns an error response with validation messages' do
        post :create, params: { user: invalid_user_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['status']['message']).to include("User couldn't be created successfully.")
      end
    end
  end
end
