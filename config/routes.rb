Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/member_details' => 'members#index'

  get '/feedback/:assesment_id' => "feedback#index"

  namespace :api do 
    namespace :v1 do  
      resources :assesments do  
        resources :questions do 
          resources :answers  , only: [:create]
        end 
        resources :feedback , only: [:create, :index]  
      end  
      resources :user_assesments , only: [:index ,:new , :create , :show]
    end 
  end 
end