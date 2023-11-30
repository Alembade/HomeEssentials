require 'csv'

# Clear existing data
User.destroy_all
Product.destroy_all
Order.destroy_all
OrderItem.destroy_all
Category.destroy_all

# Seed users
user1 = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
user2 = User.create(name: 'Jane Doe', email: 'jane@example.com', password: 'password')

# Seed categories
category1 = Category.create(name: 'Bedroom Essentials')
category2 = Category.create(name: 'Kitchenware')
category3 = Category.create(name: 'Living Room Decor')
category4 = Category.create(name: 'Home Fragrance')
category5 = Category.create(name: 'Plant Accessories')

# Seed products from CSV
csv_text = File.read(Rails.root.join('db/home_essentials.csv'))
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  product = Product.create(row.to_hash)
  # Associate product with random categories
  product.categories << [category1, category2, category3, category4, category5].sample(rand(1..3))
end
