Rails.application.routes.draw do
  get 'signups/new'
  get 'signups/registration'
  get 'signups/sms_confirmation'
  get 'signups/address'
  get 'signups/payment_method'
  get 'signups/complete'

  get 'users/show'

  devise_for :users
  root 'items#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
