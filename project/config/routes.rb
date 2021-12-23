Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'users/show', to: 'users#show'
  get 'users/update_password', to: 'users#edit'
  patch 'users/update_password', to: 'users#update'
  get 'users/show_balance', to: 'users#show_balance'
  get 'users/top_up', to: 'users#top_up'
  patch 'users/top_up', to: 'users#recharge'
  get 'users/withdraw', to: 'users#withdraw'
  patch 'users/withdraw', to: 'users#withdrawal'

  resources :products do
    get 'buy', to: 'products#buy'
    patch 'buy', to: 'products#pay'
  end

  root to: 'home#index'
end
