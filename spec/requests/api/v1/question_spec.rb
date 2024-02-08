# spec/requests/api/v1/questions_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) } 
  let(:assesment) { create(:assesment) } 

  before do
    sign_in(user) 
  end

  describe 'GET #index' do
    let!(:user) { FactoryBot.create(:user , role: "admin") }
    it 'returns a list of questions for a specific assessment' do
      question = create(:question, assesment: assesment)
      get :index, params: { assesment_id: assesment.id }
      expect(response).to have_http_status(:ok)
      expect(assigns(:questions)).to include(question)
    end
  end

  describe 'POST #create' do
  let!(:user) { FactoryBot.create(:user , role: "admin") }
    it 'creates a new question with options' do
      question_attributes = attributes_for(:question)
      post :create, params: { assesment_id: assesment.id, question: question_attributes }
      expect(response).to have_http_status(:created)
      expect(Question.last.text).to eq(question_attributes[:text])
    end
  end

  describe 'GET #show' do
  let!(:user) { FactoryBot.create(:user , role: "admin") }
    it 'returns a specific question with options for a specific assesment' do
      question = create(:question, assesment: assesment)
      get :show, params: { assesment_id: assesment.id, id: question.id }
      expect(response).to have_http_status(:ok)
      expect(assigns(:question)).to eq(question)
    end
  end

  describe 'DELETE #destroy' do
  let!(:user) { FactoryBot.create(:user , role: "admin") }
    it 'deletes a specific question' do
      question = create(:question, assesment: assesment)
      delete :destroy, params: { id: question.id }
      expect(response).to have_http_status(:ok)
      expect(Question.exists?(question.id)).to be_falsey
    end
  end
end