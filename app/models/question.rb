class Question < ApplicationRecord
  belongs_to :assesment
  has_many :options, dependent: :destroy 
  has_many :responses, dependent: :destroy 
  has_and_belongs_to_many :tags 

  validates :text, presence: true, uniqueness: true
end
