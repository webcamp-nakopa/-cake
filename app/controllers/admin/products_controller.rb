class Admin::ProductsController < ApplicationController
  def new
    @genres = Genre.all
    @product = Product.new
  end

  def create
    @genres = Genre.all
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
      flash[:notice] = "#{@product.name}が追加されました"
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.page(params[:page])
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
    @genres = Genre.all
  end

  def update
    @genres = Genre.all
    @product = Product.find(params[:id])
    if @product.update(product_params)
       redirect_to admin_products_path
       flash[:notice] = "#{@product.name}が変更されました"
    else
       render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
    flash[:notice] = "#{@product.name}が削除されました"
  end

  private
  def product_params
    params.require(:product).permit(:image, :name, :description, :genre_id, :price, :sales_status)
  end
end
