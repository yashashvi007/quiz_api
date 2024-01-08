class Response < ApplicationRecord
  # remove this
  belongs_to :assesment

  belongs_to :question
  belongs_to :user

  validates :option , presence: true
end
