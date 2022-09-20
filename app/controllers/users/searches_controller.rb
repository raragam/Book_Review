class Users::SearchesController < ApplicationController

  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		method = params[:method]
		if @model == 'user'
			@users = User.search_for(@content, method).order(id: "DESC").page(params[:page]).per(5)
		elsif @model == 'opinion'
			@opinions = Opinion.search_for(@content, method).order(id: "DESC").page(params[:page]).per(5)
		elsif @model == 'review'
			@reviews = Review.search_for(@content, method).order(id: "DESC").page(params[:page]).per(5)
		end
	end

end