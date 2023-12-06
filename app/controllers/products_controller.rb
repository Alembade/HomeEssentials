class ProductsController < ApplicationController
  def index
    @categories = Category.all
  end
  def show
    @product = Product.find(params[:id])
  end

  def show_category
    @category = Category.find(params[:id])
    @products = @category.products
  end

  def show_product
    @product = Product.find(params[:id])
  end
  def search
    @keyword = params[:keyword]
    @products = Product.where("name LIKE ? OR description LIKE ?", "%#{@keyword}%", "%#{@keyword}%").distinct
  end
  def add_to_cart
    product_id = params[:id].to_i
    @product = Product.find(product_id)

    order = current_user.orders.find_or_create_by(status: 'in_progress')
    order_item = order.order_items.find_or_initialize_by(product: @product)

    if order_item.new_record?
      order_item.quantity = 1
    else
      order_item.quantity += 1
    end

    order_item.save

    redirect_to cart_path, notice: 'Product added to cart.'
  end
  def remove_from_cart
    product_id = params[:id].to_i
    @product = Product.find(product_id)

    order = current_user.orders.find_by(status: 'in_progress')
    order_item = order.order_items.find_by(product: @product)

    if order_item
      order_item.destroy
      redirect_to cart_path, notice: 'Product removed from cart.'
    else
      redirect_to cart_path, alert: 'Product not found in the cart.'
    end
  end
end
