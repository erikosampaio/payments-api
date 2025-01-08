# spec/models/payment_spec.rb

require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:status) }

    it { should validate_length_of(:number).is_equal_to(16) }
  end

  describe 'enum' do
    it 'defines status enum correctly' do
      expect(Payment.statuses).to eq({ "pending" => 0, "paid" => 1 })
    end
  end

  describe '.providers' do
    it 'returns the correct list of providers' do
      expect(Payment.providers).to eq([:pag_seguro, :mercado_pago])
    end
  end
end
