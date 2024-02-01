require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:user_assessments) }
    it { should have_many(:assessments).through(:user_assessments) }
  end

  describe 'validations' do
    it { should define_enum_for(:role).with_values([:super_admin, :admin, :student]) }
  end

  describe 'callbacks' do
    it 'sets default role before create' do
      user = create(:user, role: nil)
      expect(user.role).to eq('student')
    end
  end

  describe 'JWT token generation' do
    it 'generates a valid JWT token' do
      user = create(:user)
      jwt_token = user.jwt_token
      expect(JWT.decode(jwt_token, Rails.application.credentials.secret_key_base)).to be_a(Hash)
    end
  end
end
