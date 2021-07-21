class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy

  attachment :image

  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true

  def add_tax_price
    (self.price * 1.10).round
  end

  def self.looks(ids)
    where("genre_id LIKE?","#{ids}")
  end
  
  def self.search_for(contents)
    Product.where("name LIKE?", "%#{contents}%")
  end

end
