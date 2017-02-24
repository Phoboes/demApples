Rails.application.routes.draw do

  get 'product_images/new'

  get 'product_images/create'

  get 'product_images/edit'

  get 'product_images/update'

  get 'product_images/destroy'

  get 'sessions/new'

  root 'pages#home'

  resources :products, :carts, :users, :cart_items

  # get '/cart_item' => 'cart_items#new'
  # post '/cart_item' => 'cart_items#create'
  # post '/cart_item/:id' => 'cart_items#update'
  # delete '/cart_item/:id' => 'cart_items#destroy'

  get 'carts/add_item/:id' => 'carts#add_item', as: :add
  get 'carts/remove_item/:id' => 'carts#remove_item', as: :remove
  get 'carts/clear' => 'carts#clear_cart', as: :clear

  get 'cart' => 'cart#show'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
