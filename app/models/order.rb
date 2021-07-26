class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  validates :customer_id, presence: true
  validates :name, presence: true

  validates :postcode, presence: true, format: {with: /\A\d{3}[-]?\d{4}\z/}
  validates :address, presence: true
  validates :shipping, presence: true
  validates :payment_methods, presence: true
  validates :total_payment, presence: true
  validates :status, presence: true
  validates :address_kind, presence: true
end
