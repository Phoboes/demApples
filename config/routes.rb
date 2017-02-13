Rails.application.routes.draw do

  get 'product_images/new'

  get 'product_images/create'

  get 'product_images/edit'

  get 'product_images/update'

  get 'product_images/destroy'

  get 'sessions/new'

  root 'pages#home'

  resources :products
  resources :carts
  resources :users

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
