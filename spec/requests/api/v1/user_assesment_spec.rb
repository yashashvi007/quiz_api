require 'rails_helper'

RSpec.describe Api::V1::UserAssesmentsController, type: :controller do
  include Devise::Test::IntegrationHelpers
  
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  let(:assesment) { FactoryBot.create(:assesment) }
  let(:user_assesment) { FactoryBot.create(:user_assesment, user: user, assesment: assesment) }

  

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns attended and not attended user_assesments' do
      user_assesment.update(attended: true)
      get :index
      expect(assigns(:user_assesments_attended)).to include(user_assesment)
      expect(assigns(:user_assesments_not_attended)).not_to include(user_assesment)
    end
  end

  describe 'POST #create' do
    context 'when user_assesment is not already assigned' do
      it 'creates a new user_assesment' do
        post :create, params: { user_id: user.id, assesment_id: assesment.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user_assesment is already assigned' do
      it 'returns unprocessable_entity status' do
        user_assesment # create an already assigned user_assesment
        post :create, params: { user_id: user.id, assesment_id: assesment.id }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns "already assigned" in the response body' do
        user_assesment # create an already assigned user_assesment
        post :create, params: { user_id: user.id, assesment_id: assesment.id }
        expect(JSON.parse(response.body)['status']).to eq('already assigned')
      end
    end

    context 'when user_assesment creation fails' do
      it 'returns unprocessable_entity status' do
        allow_any_instance_of(UserAssesment).to receive(:save).and_return(false)
        post :create, params: { user_id: user.id, assesment_id: assesment.id }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages in the response body' do
        allow_any_instance_of(UserAssesment).to receive(:save).and_return(false)
        post :create, params: { user_id: user.id, assesment_id: assesment.id }
        expect(JSON.parse(response.body)['status']).to eq('failed')
        expect(JSON.parse(response.body)['data']).not_to be_empty
      end
    end
  end
end