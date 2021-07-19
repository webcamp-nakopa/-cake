class Delivery < ApplicationRecord
  belongs_to :customer

  # VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]?\d{4}\z/

  validates :name, presence: true
  validates :postcode, presence: true, format: { with: /\A\d{3}[-]?\d{4}\z/ }
  validates :address, presence: true
end
