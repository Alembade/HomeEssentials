class OrderItemsController < ApplicationController
  def update
    @order_item = current_user.order_items.find(params[:id])

    if @order_item.update(order_item_params)
      redirect_to cart_path, notice: 'Quantity updated successfully.'
    else
      redirect_to cart_path, alert: 'Failed to update quantity.'
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end
end
