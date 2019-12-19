Rails.application.routes.draw do
  get 'card/new'

  get 'card/show'

  devise_for :users
  resources :signups, only: [:new, :create] do
    collection do
      get :registration
      post :registration
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

  resources :card, only: [:new, :show] do
    collection do
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  root 'items#index'

end
