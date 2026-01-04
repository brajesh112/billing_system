Rails.application.routes.draw do
  get "customers/show"
  get "purchases/show"
  get "billings/new"
  get "billings/create"
  get "up" => "rails/health#show", as: :rails_health_check

  root "billings#new"

  resources :billings, only: [:new, :create]
  resources :customers, only: [] do
    collection do
      get :show
    end
  end
  resources :purchases, only: [:show]
end
