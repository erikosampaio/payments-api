# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Devise modules' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'JWT revocation strategy' do
    it 'includes JTIMatcher revocation strategy' do
      expect(User.jwt_revocation_strategy).to eq(User)
    end
  end
end
