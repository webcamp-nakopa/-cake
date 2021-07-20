class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

	def search
		@model = params[:model]
		@content = params[:content]
		if @model == 'customer'
			@records = Customer.search_for(@content)
		else
			@records = Product.search_for(@content)
		end
	end
end
