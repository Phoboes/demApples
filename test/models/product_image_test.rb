# == Schema Information
#
# Table name: product_images
#
#  id         :integer          not null, primary key
#  product_id :integer
#  public_id  :text
#  image_url  :text
#  attr_desc  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ProductImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
