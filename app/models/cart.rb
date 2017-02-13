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

class Cart < ApplicationRecord
  belongs_to :user
  has_many :products
end
