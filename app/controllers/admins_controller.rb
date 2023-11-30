class AdminsController < ApplicationController
  before_action :require_admin

  def require_admin
    redirect_to root_path, alert: 'You do not have permission to access this page.' unless current_user&.admin?
  end

  def new_product
    @product = Product.new
  end

  def create_product
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: 'Product created successfully!'
    else
      render :new_product
    end
  end

  def edit_product
    @product = Product.find(params[:id])
  end

  def update_product
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to root_path, notice: 'Product updated successfully!'
    else
      render :edit_product
    end
  end

  def delete_product
    product = Product.find(params[:id])
    product.destroy
    redirect_to root_path, notice: 'Product deleted successfully!'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id)
  end
end
