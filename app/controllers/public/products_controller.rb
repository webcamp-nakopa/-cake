class Public::ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page])
    @product = Product.new
    @genres = Genre.all
  end

  def search
    @genres = Genre.all
    @product = Product.new
    @word = params[:word]
    @id = Genre.find_by(name: @word).id
    @products = Product.looks(@id)
    render :index
  end

  def show
    @genres = Genre.all
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end
end
