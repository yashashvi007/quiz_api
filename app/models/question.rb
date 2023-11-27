class Question < ApplicationRecord
  belongs_to :assesment
  has_many :options, dependent: :destroy
  has_many :responses, dependent: :destroy
  validates  :text , :correct_answer , presence: true
end
