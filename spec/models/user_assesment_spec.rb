require 'rails_helper'

RSpec.describe UserAssesment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:assesment) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:assesment_id) }
    it { should validate_inclusion_of(:attended).in_array([true, false]) }
    it { should validate_uniqueness_of(:assesment_id).scoped_to(:user_id) }
  end

  describe 'scopes' do
    it 'returns user assesments that were attempted' do
      user = create(:user)
      attended_user_assesment = create(:user_assesment, user: user, attended: true)
      unattended_user_assesment = create(:user_assesment, user: user, attended: false)

      result = UserAssesment.user_assesment_attempted(user.id, true)
      
      expect(result).to include(attended_user_assesment)
      expect(result).not_to include(unattended_user_assesment)
    end

    it 'returns user assesments that are already finished' do
      user = create(:user)
      assesment = create(:assesment)
      attended_user_assesment = create(:user_assesment, user: user, assesment: assesment, attended: true)
      unattended_user_assesment = create(:user_assesment, user: user, assesment: assesment, attended: false)

      result = UserAssesment.user_assesment_already_finished(user.id, assesment.id, true)

      expect(result).to include(attended_user_assesment)
      expect(result).not_to include(unattended_user_assesment)
    end
  end
end