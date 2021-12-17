Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'home/index'
  get 'users/update_password', to: 'users#edit'
  patch 'users/update_password', to: 'users#update'

  root to: 'home#index'
end
