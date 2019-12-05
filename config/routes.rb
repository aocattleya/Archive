Rails.application.routes.draw do
  devise_for :users
  #root 'items#index'
  root 'items#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
