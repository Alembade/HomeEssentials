class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :order_items, through: :orders
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  def admin?
    admin
  end
end
