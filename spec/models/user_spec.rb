require 'rails_helper'

RSpec.describe User, type: :model do
  it "has many user assesments" do
    expect(User.reflect_on_association(:user_assesments).macro).to eq(:has_many)
  end

 
end
