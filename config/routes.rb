Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"

  resources :profiles, only: [:show]

  resources :posts do
    resources :comments, only: %i[ create destroy update edit ]
  end

  resources :likes, only: %i[ create destroy ]

  resources :follows, only: %i[ create destroy ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "main_pages#index"
end
