class Response < ApplicationRecord
  belongs_to :assesment
  belongs_to :question
  belongs_to :user

  validates :option , presence: true
end
