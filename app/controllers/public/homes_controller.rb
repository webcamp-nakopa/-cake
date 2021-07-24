class Public::HomesController < ApplicationController
  def top
    @products = Product.where(sales_status: false).last(3)
  end

  def about
  end
end
