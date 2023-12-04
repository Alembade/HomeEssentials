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

    cart = session[:cart] || {}
    cart[product_id] ||= 0
    cart[product_id] += 1

    session[:cart] = cart

    redirect_to cart_path, notice: 'Product added to cart.'
  end
end
