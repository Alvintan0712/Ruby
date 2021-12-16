Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'home/index'
  get 'users/update_password'

  root to: 'home#index'
end
