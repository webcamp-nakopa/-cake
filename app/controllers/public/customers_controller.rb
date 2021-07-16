class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(current_customer.id)
    @customer.update(customer_params)
    redirect_to customer_path(current_customer.id)
  end

  def confirm
    @customer = Customer.find_by(params[:id])
  end

  def destroy
    @customer = Customer.find_by(params[:id])
    @customer.update(deleted_params)
    reset_session
    redirect_to homes_top_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number)
  end

  def deleted_params
    params.require(:customer).permit(:is_deleted)
  end
end
