# == Schema Information
#
# Table name: carts
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  purchase_completed :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'pry'
class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_item product_id
    if CartItem.where( cart_id: self.id, product_id: product_id ).exists?
      cart_item = CartItem.find_by( cart_id: self.id, product_id: product_id )
      cart_item.quantity += 1
      # binding.pry
      cart_item.save
    else
      # binding.pry
      CartItem.create({
        cart_id: self.id,
        product_id: product_id,
        quantity: 1
      })
    end
  end

  def remove_item product_id
    cart_item = CartItem.find_by( cart_id: self.id, product_id: product_id )
    if cart_item.quantity > 1 
      cart_item.quantity -= 1 
      cart_item.save
      # binding.pry
    else
     cart_item.destroy
    end
  end

  def clear_cart
    self.cart_items.destroy_all
  end

  def checkout_clear
    cart_items = CartItem.where( cart_id: self.id, quantity: 0 )
    cart_items.destroy_all
  end

end
