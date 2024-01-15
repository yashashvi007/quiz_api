class UserAssesment < ApplicationRecord
  belongs_to :user
  belongs_to :assesment

  validates :user_id, presence: true
  validates :assesment_id, presence: true
  validates :attended, inclusion: { in: [true, false] }

  validates :assesment_id, uniqueness: {scope: :user_id}
end
