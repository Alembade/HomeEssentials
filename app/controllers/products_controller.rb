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
end
