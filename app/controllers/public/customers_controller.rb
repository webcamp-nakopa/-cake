class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      flash[:success] = "登録情報を変更しました。"
      redirect_to customer_path(@customer.id)
    else
      render 'edit'
    end
  end

  def confirm
    @customer = Customer.find(current_customer.id)
  end

  def destroy
    @customer = Customer.find(current_customer.id)
    @customer.update(deleted_params)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number)
  end

  def deleted_params
    params.require(:customer).permit(:is_deleted)
  end
end
