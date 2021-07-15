class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :genre_id, foreign_key: true
      t.string :name
      t.text :description
      t.integer :price
      t.string :image_id
      t.boolean :sales_status,default: false

      t.timestamps
    end
  end
end
