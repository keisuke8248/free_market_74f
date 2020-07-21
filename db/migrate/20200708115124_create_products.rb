class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.string :name, null: false
      t.string :price, null: false
      t.string :description, null: false
      t.string :status, null: false
      t.string :judgment
      t.string :size, null: false
      t.string :cost, null: false
      t.string :days, null: false
      t.string :prefecture_id, null: false

      t.timestamps
    end
  end
end
