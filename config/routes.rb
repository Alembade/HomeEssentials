Rails.application.routes.draw do
  get 'checkouts/create'
  get 'order_items/update'
  root 'home#index'

  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'

  resources :products, only: [:index, :show] do
    collection do
      get 'on_sale', to: 'products#on_sale', as: 'on_sale'
      get 'new_products', to: 'products#new_products', as: 'new_products'
    end
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
    get 'edit_about', to: 'admins#edit_about', as: 'edit_about_admin'
    patch 'update_about', to: 'admins#update_about', as: 'update_about_admin'
  end

  post 'add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  resource :cart, only: [:show, :create, :destroy] do
    resources :order_items, only: [:destroy, :update], as: 'items', path: 'items'
  end
  delete 'remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  scope '/checkouts' do
  post 'create', to: 'checkouts#create', as: 'create_checkout'
  get 'success', to: 'checkouts#success', as: 'checkout_success'
  get 'cancel', to: 'checkouts#cancel', as: 'checkout_cancel'
  end
  get 'about', to: 'about#index'
end
