class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @customer = Customer.find(params[:id])
  end

  def index
    @customers = Customer.all
     @customer = Customer.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(admin_customer_params)
      flash[:success] = "登録情報を変更しました。"
      redirect_to admin_customer_path(@customer.id)
    else
      render 'edit'
    end
  end

  def search
  end

  private

  def admin_customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
