class Admin::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
  end

  private
  def product_params
    params.require(:product).permit(:image_id, :name, :description, :genre_id, :price, :sales_status)
  end
end
