require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/member_details' => 'members#index'
  get '/users/dashboard' => 'users/dashboard#index'

  namespace :api do 
    namespace :v1 do  
      resources :assesments do  
        resources :questions do 
          resources :tags , only: [:create , :index , :show]
        end 
        resources :answers  , only: [:create] 
        resources :feedback , only: [:create, :index]   
        
      end  
      resources :user_assesments  

    end 
  end 

  resources :tags , only: [:update]
  mount Sidekiq::Web => '/sidekiq'
end