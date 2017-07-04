require 'rails_helper'

# To be tested in models:
  # Validations
  # Class methods
  # Instance methods
  # Associations


RSpec.describe Cart, type: :model do


  it "is invalid without a user" do
  cart = Cart.create({
      user_id: nil,
      purchase_completed: false
    })
    expect( cart.errors.full_messages ).to include( "User must exist" )
  end

  it "belongs to a valid user" do

    user = User.create({
      name: "John",
      email: "Fake@fake.com",
      admin: false,
      password: "chicken",
      password_confirmation: "chicken"
    })

    cart = Cart.create({
      user_id: user.id,
      purchase_completed: false
    })
    expect( cart.user_id ).to eq( user.id )
  end

  it "accepts a single cart item" do

    user = User.create({
      name: "John",
      email: "Faker@fake.com",
      admin: false,
      password: "chicken",
      password_confirmation: "chicken"
    })

    cart = Cart.create({
      user_id: user.id,
      purchase_completed: false
    })

    product = Product.create( name: "Apple", price: 10.0, description: "It's an apple." )

    cart_item = CartItem.create(  product_id: product.id, quantity: 1, cart_id: cart.id )

    expect( cart.cart_items ).to include( cart_item )
  end

  it "accepts multiple cart items" do


  end

end
