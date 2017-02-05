class Product < ApplicationRecord
  belongs_to :cart, optional: true
  has_and_belongs_to_many :categories, optional: true
end