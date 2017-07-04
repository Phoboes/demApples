Rails.application.routes.draw do

  root 'pages#home'
  resources :products, :users, :cart_items, :charges
  resources :carts, only: [ :index, :show, :destroy ]

  # Session routes
  get 'sessions/new'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  get '/signup' => 'users#new', as: 'signup'

  get 'product_images/new'
  get 'product_images/create'
  get 'product_images/edit'
  get 'product_images/update'
  get 'product_images/destroy'

  # Cart item methods.
  get 'carts/clear' => 'carts#clear_cart', as: :clear
  post 'carts/add_item/:id' => 'carts#add_item', as: :add
  post 'carts/remove_item/:id' => 'carts#remove_item', as: :remove
  post 'carts/set_item/:id' => 'carts#set_item_quantity', as: :set
  delete 'carts/delete_item/:id' => 'carts#destroy_cart_item', as: :delete_item

  # Stripe
  get '/carts/payment/:id' => 'charges#new', as: :payment

end
