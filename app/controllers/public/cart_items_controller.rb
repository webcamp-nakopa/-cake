class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_items = current_customer.cart_items.all
    @cart_item.customer_id = current_customer.id
    @cart_items.each do |cart_item|
      if cart_item.product_id == @cart_item.product_id
        new_quantity = cart_item.quantity + @cart_item.quantity.to_i
        cart_item.update_attribute(:quantity, new_quantity)
        @cart_item.delete
      end
    end
      if @cart_item.quantity != nil
        @cart_item.save
        redirect_to cart_items_path
        flash[:notice] = "#{@cart_item.product.name}をカートに追加しました"
      else
        @product = Product.find_by(id: @cart_item.product_id)
        @genres = Genre.all
        flash[:notice] = "個数を選択してください"
        render template: "public/products/show"
      end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
      flash[:notice] = "#{@cart_item.product.name}の個数が変更されました"
    else
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
    flash[:notice] = "#{@cart_item.product.name}の商品をカートから削除しました"
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    if @cart_items.destroy_all
      redirect_to cart_items_path
      flash[:notice] = "カートが空になりました"
    else
      render :index
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id)
  end
end
