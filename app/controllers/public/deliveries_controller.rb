class Public::DeliveriesController < ApplicationController
  def index
    @deliveries = current_customer.deliveries
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    @delivery.save
    redirect_to deliveries_path
  end

  def edit
    @delivery = Delivery.find(params[:id])
    @delivery.customer.id == current_customer.id
  end

  def update
     @delivery = Delivery.find(params[:id])
     @delivery.update(delivery_params)
     redirect_to deliveries_path
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to deliveries_path
  end

  private

  def delivery_params
    params.require(:delivery).permit(:name, :postcode, :address)
  end
end
