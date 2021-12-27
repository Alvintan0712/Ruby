Rails.application.routes.draw do
  # Cart
  get 'cart', to: 'orders#cart'

  # Orders
  resources :orders do
    patch 'send', to: 'orders#send_item'
    patch 'receive', to: 'orders#receive_item'

    # Rates
    resources :rates
  end

  # Devise User
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Followships
  get 'followships', to: 'followships#index'

  # Shop
  get 'shops/manage', to: 'shops#manage'
  resources :shops, except: [ :index ] do
    patch 'follow', to: 'followships#create'
    delete 'unfollow', to: 'followships#destroy'
  end

  # Show Profile
  get 'users/show', to: 'users#show'

  # Show Balance
  get 'users/show_balance', to: 'users#show_balance'

  # User Update password
  get 'users/update_password', to: 'users#edit'
  patch 'users/update_password', to: 'users#update'

  # User Top up
  get 'users/top_up', to: 'users#top_up'
  patch 'users/top_up', to: 'users#recharge'

  # User Withdraw
  get 'users/withdraw', to: 'users#withdraw'
  patch 'users/withdraw', to: 'users#withdrawal'

  # Favourites
  get 'favourites', to: 'favourites#index'
  resources :products, except: [ :index ] do
    resources :images, except: [ :index ]
    resources :items, except: [ :index ]
    patch 'favourites', to: 'favourites#create'
    delete 'favourites', to: 'favourites#destroy'
  end


  # Home
  get 'search', to: 'home#search'
  get 'about', to: 'home#about'
  root to: 'home#index'
end
