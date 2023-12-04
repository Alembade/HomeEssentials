class CartsController < ApplicationController
  def show
    @cart = session[:cart] || {}
  end
end
