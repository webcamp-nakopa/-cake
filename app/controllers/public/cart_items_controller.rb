class Public::CartItemsController < ApplicationController
  def index
    @customer = current_customer
    @cart_items = CartItem.where(customer_id: @customer.id).all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
    else
      redirect_to products_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      redirect_to products_path
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id)
  end
end
