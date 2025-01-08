require 'rails_helper'

RSpec.describe Payments::Emission do
  let(:payment) { create(:payment, status: :pending) }
  subject { Payments::Emission }

  context 'when Pag Seguro provider successful' do
    it 'returns success with a message successfuly' do
      result = subject.new(payment, Payment.providers).call
      expect(result[:success]).to be true
      expect(result[:message]).to include('Payment created successfully with Pag seguro.')
      expect(payment.reload.status).to eq 'paid'
    end
  end

  context 'when Mercado Pago provider successful' do
    it 'returns success with a message successfuly' do
      payment.due_date = nil
      result = subject.new(payment, Payment.providers).call
      expect(result[:success]).to be true
      expect(result[:message]).to include('Payment created successfully with Mercado pago.')
      expect(payment.reload.status).to eq 'paid'
    end
  end

  context 'when Pag Seguro provider unsuccessful' do
    it 'returns failure with a error message' do
      payment.due_date = nil
      result = subject.new(payment, [Payment.providers.first]).call
      expect(result[:success]).to be false
      expect(result[:message]).to include('Error with provider Pag seguro')
      expect(payment.reload.status).to eq 'pending'
    end
  end

  context 'when Mercado Pago provider unsuccessful' do
    it 'returns failure with a error message' do
      payment.cvc = nil
      result = subject.new(payment, [Payment.providers.second]).call
      expect(result[:success]).to be false
      expect(result[:message]).to include('Error with provider Mercado pago')
      expect(payment.reload.status).to eq 'pending'
    end
  end

  context 'when both providers are unsuccessful' do
    it 'returns failure with a error message' do
      payment.cvc = nil
      payment.due_date = nil
      result = subject.new(payment, Payment.providers).call
      expect(result[:success]).to be false
      expect(result[:message]).to include('Error with provider')
      expect(payment.reload.status).to eq 'pending'
    end
  end

  context 'when invalid provider' do
    it 'returns failure with a error message' do
      result = subject.new(payment, [:invalid_provider]).call
      expect(result[:success]).to be false
      expect(result[:message]).to include('Invalid provider')
      expect(payment.reload.status).to eq 'pending'
    end
  end
end
