require 'rails_helper'

RSpec.describe Assesment, type: :model do

  context "for associations" do
    it "Assesmet has many questions" do
      expect(Assesment.reflect_on_association(:questions).options[:dependent]).to eq(:destroy)
    end 

    it "destroys dependent questions when the assesment is destroyed" do
      assesment = create(:assesment)
      question = create(:question, assesment: assesment)
      expect { assesment.destroy }.to change { Question.count }.by(-1)
    end

    it "has many user_assesments" do
      expect(Assesment.reflect_on_association(:user_assesments).macro).to eq(:has_many)
    end

    it "has many users through user_assesments" do
      expect(Assesment.reflect_on_association(:users).through_reflection.name).to eq(:user_assesments)
    end

    it "has many users" do
      expect(Assesment.reflect_on_association(:users).macro).to eq(:has_many)
    end

  end   

  context "for validations" do 
    subject { described_class.new(title: "Anything", duration: 5 , difficulty_level: 1 , is_archived: false , scheduled_at: Time.current, user_id: 3) } 
    it "validates the assesments title" do
      expect(subject).to be_valid
    end

    it "validates if title is not given" do
      subject.title = nil 
      expect(subject).to_not be_valid
    end

    it "validates the duration to be greater than 0" do
      subject.duration = 0
      expect(subject).to_not be_valid
    end

    it "validates the duration to be an integer" do
      subject.duration = 2.5
      expect(subject).to_not be_valid
    end

    it "validates the difficulty_level presence" do
      subject.difficulty_level = nil
      expect(subject).to_not be_valid
    end

    it "validates the uniqueness of title" do
      existing_assesment = create(:assesment, title: "Existing Assesment")
      subject.title = existing_assesment.title
      expect(subject).to_not be_valid
    end

    it "validates the end_time before create" do
      subject.scheduled_at = Time.current
      subject.duration = 5
      subject.save
      expect(subject.end_time).to eq(subject.scheduled_at + 60 * subject.duration)
    end
  end 
end