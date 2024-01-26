class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true

  has_one_attached :image
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :categories
end
