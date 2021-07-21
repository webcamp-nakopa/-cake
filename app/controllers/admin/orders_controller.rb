class Admin::OrdersController < ApplicationController
  def index


    @orders = Order.order(id: :DESC)

  end
  def customerindex
    @orders = Order.where(customer_id: params[:id])
    render :index
  end

  def show
    @order = Order.find(params[:id])
  end
end
