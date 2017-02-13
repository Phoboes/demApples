class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.text :name
      t.text :email, unique: true
      t.boolean :admin
      t.string :password_digest

      t.timestamps
    end
  end
end
