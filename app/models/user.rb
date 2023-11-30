class User < ApplicationRecord
  has_secure_password
  has_many :orders
  def admin?
    admin
  end
end
