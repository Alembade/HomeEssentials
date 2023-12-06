class Admin::AdminsController < ApplicationController
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
  def update_about
    Rails.application.config.about_text = params[:about_text]
    Rails.application.config.contact_phone = params[:contact_phone]
    Rails.application.config.contact_email = params[:contact_email]

    redirect_to root_path, notice: 'About information updated successfully!'
  end
  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :image, category_ids: []).tap do |whitelisted|
      new_category_name = params.dig(:product, :new_category_name)
      whitelisted[:categories_attributes] = [{ name: new_category_name }] if new_category_name.present?
    end
  end
end
