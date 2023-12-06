class CartsController < ApplicationController
  before_action :require_login

  def show
    @order_items = current_user.order_items.includes(:product)
  end

  def remove_item
    order_item = current_user.order_items.find(params[:id])
    order_item.destroy

    redirect_to cart_path, notice: 'Item removed from the cart.'
  end
end
