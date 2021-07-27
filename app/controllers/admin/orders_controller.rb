class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @orders = Order.order(id: :DESC)
  end
  def customerindex
    @orders = Order.where(customer_id: params[:id])
    render :index
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "注文ステータスを変更しました。"
      if @order.status == 1
        @order_details = @order.order_details
        @order_details.each do |od|
          @order_detail = OrderDetail.find_by(id: od.id)
          @order_detail.update(order_detail1)
        end
      end
      redirect_to admin_order_path(@order)
    else
      flash[:alert]="注文ステータスの変更に失敗しました。"
      render :show
    end

  end



  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
  def order_detail1
    {production_status: 1}
  end
end
