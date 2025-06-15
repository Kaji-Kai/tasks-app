Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  devise_for :users

  #-----root path-----
  root "home#index"

  #-----resources-----

  resources :projects do
    resources :tasks, shallow: true do
      resources :comments, shallow: true
    end
  end

  resources :tasks, only: [:index, :show]
  resources :comments, only: [:index, :edit, :update, :destroy]


end
