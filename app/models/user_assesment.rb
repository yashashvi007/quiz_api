class UserAssesment < ApplicationRecord
  belongs_to :user
  belongs_to :assesment

  validates :assesment_id, uniqueness: {scope: :user_id}
end
