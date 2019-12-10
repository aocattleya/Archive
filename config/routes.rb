Rails.application.routes.draw do
  get 'signups/new'

  get 'users/show'
  get 'users/profile'

  devise_for :users
  root 'items#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
