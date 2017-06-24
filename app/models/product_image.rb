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

class ProductImage < ApplicationRecord
  belongs_to :product
  after_destroy :delete_cloudinary_image
  def delete_cloudinary_image
      Cloudinary::Uploader.destroy( self.public_id ) # Destroy image hosted on Cloudinary.
  end

end
