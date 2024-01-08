FactoryBot.define do
  factory :user_assesment do
    user
    assesment
    attended { false }
    score { Faker::Number.between(from: 0, to: 100) } 
  end
end