Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  resources :signups, only: [:new, :create] do
    collection do
      get :registration
      post :registration
      get :sns_registration
      post :sns_registration
      get :sms_confirmation
      post :sms_confirmation
      get :address
      post :address
      get :payment_method
      post :payment_method
      get :complete
    end
  end

  resources :users, only: [:show] do
    collection do
      get :confirm
      get :profile
      get :identification
      get :card
      get :logout
    end
  end

  resources :items do
    collection do
      get :confirm
    end
  end

  resources :categories, only: [:index, :show]

  root 'items#index'

end
