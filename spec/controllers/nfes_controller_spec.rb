require 'rails_helper'

RSpec.describe Api::V1::PaymentsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:user) { create(:user) }

  describe 'GET #index' do
    include_context 'when validate permissions'

    let!(:payments) { create_list(:payment, 3) }

    it 'returns all payments in the correct order' do
      get :index
      expect(response).to have_http_status(:ok)
      payments_ids_reverse =  response.parsed_body[:data].map { |payment| payment['id'] }.reverse
      expect(payments_ids_reverse).to eq(payments.map(&:id))
    end
  end

  describe "GET #show" do
    include_context 'when validate permissions'

    let!(:payment) { create(:payment) }

    context "when payment exists" do
      it "returns a successful response" do
        get :show, params: { id: payment.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when payment does not exist" do
      it "returns a not found response" do
        get :show, params: { id: 'invalid' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:valid_params) do
      {
        payment: {
          name: 'Test Payment',
          number: '1234567890123456',
          due_date: '2025-01-31',
          cvc: '123',
          amount: 1000
        }
      }
    end

    context 'when the payment is successfully created and emitted' do
      before do
        allow(Payments::Emission).to receive(:new).and_return(double(call: { success: true, message: 'Payment emitted successfully' }))
      end

      it 'returns a created status' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(response.parsed_body['message']).to eq('Payment emitted successfully')
      end
    end

    context 'when the payment is created but emission fails' do
      before do
        allow(Payments::Emission).to receive(:new).and_return(double(call: { success: false, message: 'Emission failed' }))
      end

      it 'returns an unprocessable entity status with the emission failure message' do
        post :create, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['message']).to eq('Emission failed')
      end
    end

    context 'when the payment creation fails' do
      before do
        allow_any_instance_of(Payment).to receive(:save).and_return(false)
        allow_any_instance_of(Payment).to receive_message_chain(:errors, :full_messages).and_return(['Name can\'t be blank'])
      end

      it 'returns an unprocessable entity status with the validation error messages' do
        post :create, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['message']).to eq('Name can\'t be blank')
      end
    end
  end
end
