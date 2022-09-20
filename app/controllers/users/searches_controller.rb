class Users::SearchesController < ApplicationController

  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		method = params[:method]
		if @model == 'user'
			@users = User.search_for(@content, method).order(id: "DESC")
		elsif @model == 'opinion'
			@opinions = Opinion.search_for(@content, method).order(id: "DESC")
		elsif @model == 'review'
			@reviews = Review.search_for(@content, method).order(id: "DESC")
		end
	end

end