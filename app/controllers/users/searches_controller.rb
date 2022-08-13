class Users::SearchesController < ApplicationController

  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		elsif @model == 'opinion'
			@records = Opinion.search_for(@content, @method)
		elsif @model == 'review'
			@records = Review.search_for(@content, @method)
		end
	end

end
