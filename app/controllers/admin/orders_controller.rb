class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.order(id: :DESC)
    @order_details = OrderDetail.all
  end

  def show
  end
end
