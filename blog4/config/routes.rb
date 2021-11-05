Rails.application.routes.draw do
  root 'blogs#index'
  
  resources :users do
    collection do 
      get 'login'
      post 'do_login'
      get 'logout'
    end
  end

  resources :blogs do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
