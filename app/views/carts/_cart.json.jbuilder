# json.extract! cart, :id, :user_id, :purchase_completed, :created_at, :updated_at

json.cart do
  json.id @cart.id
  json.user_id cart.user_id
  json.purchase_completed cart.purchase_completed

  json.cartItems( @cart.cart_items ) do | item |
    json.cartItemId item.id
    json.quantity item.quantity
    json.cartProductId item.product.id
    json.productName item.product.name
    json.productPrice item.product.price
  end
end 

# json.url cart_url(cart, format: :json)