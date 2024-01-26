class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 1000 }
end
