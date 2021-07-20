class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :product_id, foreign_key: true, null: false, index: true
      t.integer :order_id, foreign_key: true, null: false, index: true
      t.integer :quantity, null: false
      t.integer :price, null: false
      t.integer :production_status, null: false

      t.timestamps
    end
  end
end
