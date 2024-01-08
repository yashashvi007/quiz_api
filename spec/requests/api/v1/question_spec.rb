# spec/requests/api/v1/questions_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :request do

  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }
  before do
    sign_in user
  end

  let(:valid_headers) do
    {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json',
      'Authorization' => "Bearer #{user.jwt_token}"
    }
  end

  describe 'GET #index' do
    it 'returns a list of questions with options for a specific assesment' do
      assesment = FactoryBot.create(:assesment)
      question1 = FactoryBot.create(:question, assesment: assesment)
      question2 = FactoryBot.create(:question, assesment: assesment)
      
      get api_v1_assesment_questions_path(assesment), headers: valid_headers

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response['assesment']['id']).to eq(assesment.id)
      expect(json_response['questions'].length).to eq(2)
    end
  end

  describe 'POST #create' do
    it 'creates a new question with options' do
      assesment = FactoryBot.create(:assesment)
      question_params = {
        text: 'What is the capital of France?',
        options: [
          { option: 'A', description: 'Paris', is_correct: true },
          { option: 'B', description: 'Berlin', is_correct: false }
        ]
      }

      post api_v1_assesment_questions_path(assesment), params: { question: question_params }.to_json, headers: valid_headers

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response['question']['text']).to eq(question_params[:text])
      expect(json_response['options'].length).to eq(2)
    end
  end

  describe 'GET #show' do
    it 'returns a specific question with options for a specific assesment' do
      assesment = FactoryBot.create(:assesment)
      question = FactoryBot.create(:question, assesment: assesment)

      get api_v1_assesment_question_path(assesment, question), headers: valid_headers

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response['question']['id']).to eq(question.id)
      expect(json_response['question']['options'].length).to eq(question.options.count)
    end
  end
end
