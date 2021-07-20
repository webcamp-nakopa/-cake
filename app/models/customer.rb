class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cart_items, dependent: :destroy
  has_many :deliveries, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: {with: /\A[ぁ-んァ-ン]+\z/}
  validates :first_name_kana, presence: true, format: {with: /\A[ぁ-んァ-ン]+\z/}
  validates :postal_code, presence: true, format: {with: /\A\d{3}[-]?\d{4}\z/}
  validates :address, presence: true
  validates :telephone_number, presence: true, format: {with: /\A0\d{9,10}\z/}

  def self.search_for(contents)
    Customer.where("first_name LIKE? OR last_name LIKE? OR first_name_kana LIKE? OR last_name_kana LIKE?", "%#{contents}%", "%#{contents}%", "%#{contents}%", "%#{contents}%")
  end
end
