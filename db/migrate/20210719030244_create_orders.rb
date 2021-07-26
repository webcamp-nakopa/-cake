class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id, foreign_key: true, null: false, index: true
      t.string :name, null: false
      t.string :postcode, null: false
      t.string :address, null: false
      t.integer :shipping, null: false
      t.integer :payment_methods, null: false
      t.integer :total_payment, null: false
      t.integer :status, null: false
      t.integer :address_kind, null: false

      t.timestamps
    end
  end
end
