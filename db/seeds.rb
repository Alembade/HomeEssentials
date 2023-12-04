require 'csv'

User.destroy_all
Product.destroy_all
Order.destroy_all
OrderItem.destroy_all
Category.destroy_all

ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='users'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='products'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='orders'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='order_items'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='categories'")

filename = Rails.root.join('db/home_essentials.csv')

def determine_category_for_product(product_name)
  case product_name
  when /bed sheets|blanket|pillow/
    'Bedroom Essentials'
  when /cookware|kitchen scale|coffee maker/
    'Kitchenware'
  when /throw pillows|blanket|ottoman/
    'Living Room Decor'
  when /essential oil diffuser|scented candles|indoor string lights/
    'Home Fragrance'
  when /plant pots|wall shelves|indoor string lights/
    'Plant Accessories'
  else
    'Uncategorized'
  end
end

CSV.foreach(filename, headers: true) do |row|
  product = Product.create(
    name: row['name'],
    description: row['description'],
    price: row['price']
  )

  category_name = determine_category_for_product(product.name.downcase)
  category = Category.find_or_create_by(name: category_name)

  product.categories << category
end
