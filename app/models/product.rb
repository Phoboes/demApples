# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  price       :float
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  validates :name, uniqueness: true
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_and_belongs_to_many :categories, optional: true
  has_many :product_images, dependent: :destroy
end
