class Public::DeliveriesController < ApplicationController
  def index
    @deliveries = current_customer.deliveries
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      redirect_to deliveries_path
      flash[:notice] = "配送先を追加しました"
    else
      @deliveries = current_customer.deliveries
      render 'index'
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
    @delivery.customer.id == current_customer.id
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
     redirect_to deliveries_path
     flash[:notice] = "配送先を変更しました"
    else
      render 'edit'
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to deliveries_path
    flash[:notice] = "配送先を削除しました"
  end

  private

  def delivery_params
    params.require(:delivery).permit(:name, :postcode, :address)
  end
end
