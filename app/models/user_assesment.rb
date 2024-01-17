class UserAssesment < ApplicationRecord
  belongs_to :user
  belongs_to :assesment

  validates :user_id, presence: true
  validates :assesment_id, presence: true
  validates :attended, inclusion: { in: [true, false] }

  validates :assesment_id, uniqueness: {scope: :user_id}

  scope :user_assesment_attempted , ->(user_id , attended) { where(["user_id = ? and attended = ?" , user_id , attended])}
  scope :user_assesment_already_finished, ->(user_id , assesment_id , attended) {where(["user_id = ? and assesment_id = ? and attended = ?", user_id, assesment_id , attended])}
end
