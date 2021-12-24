Rails.application.routes.draw do
  resources :orders do
    patch 'send', to: 'orders#send_item'
    patch 'receive', to: 'orders#receive_item'
    # TODO: get and patch rate routes
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'shops/manage', to: 'shops#manage'
  resources :shops

  get 'users/show', to: 'users#show'
  get 'users/update_password', to: 'users#edit'
  patch 'users/update_password', to: 'users#update'
  get 'users/show_balance', to: 'users#show_balance'
  get 'users/top_up', to: 'users#top_up'
  patch 'users/top_up', to: 'users#recharge'
  get 'users/withdraw', to: 'users#withdraw'
  patch 'users/withdraw', to: 'users#withdrawal'

  resources :products

  get 'about', to: 'home#about'
  root to: 'home#index'
end
