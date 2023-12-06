class CheckoutsController < ApplicationController
  before_action :require_login

  def create
    line_items = []

    current_user.order_items.each do |order_item|
      product = order_item.product

      line_items << {
        price_data: {
          currency: 'cad',
          product_data: {
            name: product.name,
            description: product.description,
          },
          unit_amount: (product.price * 100).to_i,
        },
        quantity: order_item.quantity
      }
    end

    line_items << {
      price_data: {
        currency: 'cad',
        product_data: {
          name: 'GST',
          description: 'Goods and Services Tax',
        },
        unit_amount: (current_user.order_items.sum { |item| item.product.price * 0.05 * item.quantity } * 100).to_i,
      },
      quantity: 1
    }

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      mode: 'payment',
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url,
      line_items: line_items
    )

    redirect_to @session.url, allow_other_host: true
  end
end
