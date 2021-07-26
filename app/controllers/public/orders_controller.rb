class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @cart_items = @customer.cart_items.joins(:product).where(products: {sales_status: false})
    if @cart_items.empty?
      flash[:alert] = "カートの中身が空です。"
      redirect_to '/products'

    else
      @order = Order.new
      @delivery = Delivery.new
    end
  end

  def confirm
    flash.clear

    @order= Order.new(order_params)
    @order_detail = OrderDetail.new
    @customer = current_customer

    @cart_items = CartItem.joins(:product).where(products: {sales_status: false}).where(customer_id: @customer.id)
    if @cart_items.empty?
      flash[:alert] = "カートの中身が空です。"
      render :new
    else
      @order.customer_id=@customer.id
      @order.shipping = 800

      if @order.address_kind==1
        @order.address = @customer.address
        @order.postcode = @customer.postal_code
        @order.name = 'aaa'

      elsif @order.address_kind == 2
        @delivery = Delivery.find_by(id: params[:order][:deliveryid])

        @order.address = @delivery.address
        @order.postcode = @delivery.postcode
        @order.name = @delivery.name

      elsif @order.address_kind == 3
        @newdelivery = Delivery.new
        @newdelivery.customer_id = @customer.id
        @newdelivery.postcode = @order.postcode
        @newdelivery.address = @order.address
        @newdelivery.name = @order.name
      end



      @order.status = 0
      if @order.address_kind==nil or @order.payment_methods==nil
        if  @order.payment_methods==nil
          flash[:alert1] = "お支払い方法を選択してください。"
        end
        if @order.address_kind==nil
          flash[:alert2] = "お届け先を選択してください。"
        end
        render :new
      end

    end


  end

  def create

    @order= Order.new(order_params)

    @customer = current_customer

    @cart_items = CartItem.joins(:product).where(products: {sales_status: false}).where(customer_id: @customer.id)

    @order.customer_id=@customer.id
    @order.shipping = 800
    @customer = current_customer
    @order.status = 0


    if @order.save
      @cart_items.each{|cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.product_id = cart_item.product_id
        @order_detail.quantity = cart_item.quantity
        @order_detail.price = cart_item.product.add_tax_price.to_s(:price)
        @order_detail.production_status = 0
        @order_detail.save
      }
      @cart_items = current_customer.cart_items
      @cart_items.destroy_all
      redirect_to orders_thank_you_path
      if @order.address_kind == 3
        @newdelivery = Delivery.new
        @newdelivery.customer_id = @customer.id
        @newdelivery.postcode = @order.postcode
        @newdelivery.address = @order.address
        @newdelivery.name = @order.name
        if @newdelivery.save
          render :new
        end
      end
    else
      render :new
    end
  end


  def index

    @orders = current_customer.orders.order(id: :DESC)
    @order_details = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
  end
  def thank_you

  end


  def order_params
    params.require(:order).permit(:customer_id, :name, :postcode, :address, :shipping, :payment_methods, :total_payment, :status,:address_kind)
  end
  def delivery_params
    params.require(:delivery).permit(:name, :postcode, :address)
  end
end
