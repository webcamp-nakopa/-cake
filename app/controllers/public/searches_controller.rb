class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

	def search
		@content = params[:content]
		@records = Product.search_for(@content)
	end
end
