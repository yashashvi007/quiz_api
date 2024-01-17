class Response < ApplicationRecord
  # remove this
  belongs_to :assesment

  belongs_to :question
  belongs_to :user

  validates :option , presence: true

  scope :user_response_for_assesment, -> (user_id , assesment_id) { where(["user_id = ? AND assesment_id = ?" , user_id , assesment_id]) }
end
