FactoryBot.define do 
  factory :assesment do
    title { "Question" }
    duration { 5 }
    difficulty_level { 1 }
    is_archived { true }
    scheduled_at { Time.now}
    user_id { 1 }
  end 
end 
