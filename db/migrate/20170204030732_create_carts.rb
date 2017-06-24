class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.boolean :purchase_completed, default: false

      t.timestamps
    end
  end
end
