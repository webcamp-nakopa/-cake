class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)
      flash[:notice] = "製造ステータスを変更しました。"
      if @order_detail.production_status ==2 and @order.status == 1
        @order.update(order2)
      end
      if @order.order_details.where(production_status: 3).count == @order.order_details.count
        @order.update(order3)
      else
        if @order.status ==3
          @order.update(order2)
        end
      end
        redirect_to admin_order_path(@order)
    else
      flash[:alert] = "製造ステータスの変更に失敗しました。"
      render admin_order_path(@order)
    end
  end
  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
  def order2
    {status: 2}
  end
  def order3
    {status: 3}
  end
end
