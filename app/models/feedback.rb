class Feedback < ApplicationRecord
  belongs_to :assesment
  belongs_to :user
end
