Rails.application.routes.draw do
  root 'home#index'

  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'

  resources :products, only: [:index, :show] do
    get 'show_category/:id', to: 'products#show_category', on: :member, as: :show_category
    get 'show_product/:id', to: 'products#show', on: :member, as: :show_product
    get 'search', on: :collection
  end

  get 'logout', to: 'sessions#destroy', as: 'logout'

  namespace :admin do
    get 'new_product', to: 'admins#new_product', as: 'new_product'
    post 'create_product', to: 'admins#create_product', as: 'create_product'
    get 'edit_product/:id', to: 'admins#edit_product', as: 'edit_product'
    patch 'update_product/:id', to: 'admins#update_product', as: 'update_product'
    delete 'delete_product/:id', to: 'admins#delete_product', as: 'delete_product'
  end

  post 'add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  resource :cart, only: [:show, :create, :destroy] do
    resources :order_items, only: [:destroy], as: 'items', path: 'items'
  end
  delete 'remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
end
