Rails.application.routes.draw do
  resources :signups, only: [:new] do
    collection do
      get :registration
      get :sms_confirmation
      get :address
      get :payment_method
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

  devise_for :users
  #root 'items#index'
  root 'items#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
