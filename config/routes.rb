Rails.application.routes.draw do

  resources :card, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'card#pay'
    end
  end

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
      post :complete
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

  namespace :items do
    resources :searches, only: :index
  end

  resources :items do
    member do
      get :confirm
      get :category
    end
  end

  resources :categories, only: [:index, :show] do
    collection do
      get 'get_child_category'
      get 'get_grandchild_category'
    end
  end

  root 'items#index'

end
