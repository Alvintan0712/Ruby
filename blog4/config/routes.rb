Rails.application.routes.draw do
  devise_for :users
  get "users/show" => "users#show"
  get "users/edit" => "users#edit"

  resources :blogs do
    resources :comments
  end

  root "blogs#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
