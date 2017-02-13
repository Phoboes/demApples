class CreateProductImages < ActiveRecord::Migration[5.0]
  def change
    create_table :product_images do |t|
      t.integer :product_id
      t.text :public_id
      t.text :url
      t.text :attr_desc

      t.timestamps
    end
  end
end
