class Product < ApplicationRecord
  has_one_attached :image
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :categories
end
