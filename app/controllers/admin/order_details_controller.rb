class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)
      flash[:notice] = "製造ステータスを変更しました。"
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
end
