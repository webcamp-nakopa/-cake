class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  validates :production_status, presence: true
end
