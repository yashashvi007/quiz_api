FactoryBot.define do 
  factory :assesment do
    title { "Question" }
    duration { 5 }
    difficulty_level { "medium"  }
    is_archived { false }
    scheduled_at { Time.now }
    user_id { 1 }
  end 
end 
