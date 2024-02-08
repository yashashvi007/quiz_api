# spec/controllers/api/v1/assessments_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::AssesmentsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryBot.create(:user) }

  describe "GET #index" do
    before do
      sign_in(user)
    end
   
    it "returns a success response" do
      get :index, format: :json
      expect(response).to have_http_status(:success)
    end

    it "assigns all assesments as @assesments" do 
      assesment = FactoryBot.create(:assesment)  
      get :index, format: :json
      expect(assigns(:assesments)).to eq([assesment])   
    end
  end
  

  describe "GET #show" do
    before do
      sign_in(user)
    end
    it "returns a success response" do
      assesment = FactoryBot.create(:assesment)
      get :show, params: { id: assesment.to_param }, format: :json
      expect(response).to be_successful
    end

    it "assigns the requested assesment as @assesment" do
      assesment = FactoryBot.create(:assesment)
      get :show, params: { id: assesment.to_param }, format: :json
      expect(assigns(:assesment)).to eq(assesment)
    end
  end

  describe "POST #create" do
    let!(:user) { FactoryBot.create(:user , role: "admin") }

    before do
      sign_in(user)
    end

    context "with valid parameters" do
      let(:valid_params) { FactoryBot.attributes_for(:assesment) }
      it "creates a new Assesment" do
        expect {
          post :create, params: { assesment: valid_params }, format: :json
        }.to change(Assesment, :count).by(1)
      end

      it "renders a JSON response with the new assesment" do
        post :create, params: { assesment: valid_params }, format: :json
       
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["assesment"]).to be_present
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { FactoryBot.attributes_for(:assesment, title: nil) }

      it "does not create a new assessment" do
        expect {
          post :create, params: { assesment: invalid_params }, format: :json
        }.to_not change(Assesment, :count)
      end

      it "renders a JSON response with a message and status :unprocessable_entity" do
        post :create, params: { assesment: invalid_params }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["message"]).to eq("Validation failed: Title can't be blank")
      end
    end
  end

  describe "PATCH #update" do

  let!(:user) { FactoryBot.create(:user , role: "admin") }

  before do
    sign_in(user)
  end
  
  context "with valid parameters" do
      let(:new_attributes) do
        { title: 'New Title' }
      end

      it "updates the requested assesment" do 
        assesment = FactoryBot.create(:assesment)
        patch :update, params: { id: assesment.to_param, assesment: new_attributes }, format: :json
        assesment.reload
        expect(assesment.title).to eq('New Title')
      end

      it "renders a JSON response with the assesment" do
        assesment = FactoryBot.create(:assesment)
        patch :update, params: { id: assesment.to_param, assesment: new_attributes }, format: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the assesment" do
        assesment = FactoryBot.create(:assesment)
        patch :update, params: { id: assesment.to_param, assesment: FactoryBot.attributes_for(:assesment, title: nil) }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
  let!(:user) { FactoryBot.create(:user , role: "admin") }

  before do
    sign_in(user)
  end
    it "destroys the requested assesment" do
      assesment = FactoryBot.create(:assesment)
      delete :destroy, params: { id: assesment.to_param }, format: :json
      assesment.reload
      expect(assesment.is_archived?).to eq(true)
    end
  end
end
