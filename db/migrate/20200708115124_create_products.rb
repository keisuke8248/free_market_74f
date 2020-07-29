class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :brand
      t.string :name, null: false
      t.string :price, null: false
      t.string :description, null: false
      t.string :status, null: false
      t.string :judgment
      t.string :size
      t.string :cost, null: false
      t.string :days, null: false
      t.integer :prefecture_id, null: false, default: "0"
      t.integer :seller_id
      t.integer :buyer_id

      t.timestamps
    end
  end
end
