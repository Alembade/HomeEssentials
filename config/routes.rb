Rails.application.routes.draw do
  root 'home#index'

  # User registration
  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create'

  # User login and dashboard
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'

  get 'logout', to: 'sessions#destroy', as: 'logout'
  namespace :admin do
    get 'new_product', to: 'admins#new_product', as: 'new_product'
    post 'create_product', to: 'admins#create_product', as: 'create_product'
    get 'edit_product/:id', to: 'admins#edit_product', as: 'edit_product'
    patch 'update_product/:id', to: 'admins#update_product', as: 'update_product'
    delete 'delete_product/:id', to: 'admins#delete_product', as: 'delete_product'
  end
end
