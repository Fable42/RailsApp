Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  resources :users do
    member do
      post 'follow', to: "follows#create", as: "follow"
      post 'unfollow', to: "follows#destroy", as: "unfollow"
      post 'pin', to: "follows#pin", as: "pin"
      post 'unpin', to: "follows#unpin", as: "unpin"
    end
  end

  resources :profiles, only: %i[ show ]

  resources :posts do
    resources :comments, only: %i[ create destroy ]
    resources :views, only: %i[ create ]
  end

  resources :likes, only: %i[ create destroy ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
      #member do 
      #post 'view', to: "views#create"
    #end
  root to: "main_pages#index"
end
