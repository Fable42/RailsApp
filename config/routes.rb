Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: %i[ create destroy update ]
  end
  resources :likes, only: %i[ create destroy ]
  #resources :posts, only: %i[new create index update edit destroy]

  #resources :posts, only: [:new, :update, :edit, :create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "main_pages#index"
end
