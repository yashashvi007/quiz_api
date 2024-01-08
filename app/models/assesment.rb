class Assesment < ApplicationRecord

  before_create do
    self.end_time = self.scheduled_at + 60.minutes
  end

  has_many :questions, dependent: :destroy
  has_many :user_assesments
  has_many :users, :through => :user_assesments
  enum :difficulty_level, [:easy , :medium, :hard]

  validates :title, :duration , :difficulty_level, presence: true
end
