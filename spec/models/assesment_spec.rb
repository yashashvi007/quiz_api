require 'rails_helper'

RSpec.describe Assesment, type: :model do
  describe 'associations' do
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:user_assesments) }
    it { should have_many(:users).through(:user_assesments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:duration) }
    it { should validate_numericality_of(:duration).only_integer.is_greater_than(0) }
    it { should validate_presence_of(:difficulty_level) }
  end

  describe 'callbacks' do
    it 'sets end_time before create' do
      assesment = create(:assesment, scheduled_at: Time.current, duration: 60)
      expect(assesment.end_time).to eq(assesment.scheduled_at + 60.minutes)
    end
  end
end