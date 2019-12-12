Rails.application.routes.draw do
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

  get 'users/show'

  resources :items do
    collection do
      get :confirm
    end
  end


  root 'items#index'

end
