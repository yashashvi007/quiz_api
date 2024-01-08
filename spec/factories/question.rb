FactoryBot.define do
  factory :question do
    text { Faker::Lorem.question }
    assesment
  end
end
