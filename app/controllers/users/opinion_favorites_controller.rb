class Users::OpinionFavoritesController < ApplicationController

  def create
    opinion = Opinion.find(params[:opinion_id])
    opinion_favorite = current_user.opinion_favorites.new(opinion_id: opinion.id)
    opinion_favorite.save
    if params[:opinion][:up] == '1'
       redirect_to users_opinions_path
    elsif params[:opinion][:up] == '2'
       redirect_to users_opinion_path(opinion)
    elsif params[:opinion][:up] == '3'
       redirect_to opinions_user_index_users_user_path(opinion)
    else
       redirect_to users_opinion_path(opinion)
    end
  end

  def destroy
    opinion = Opinion.find(params[:opinion_id])
    opinion_favorite = current_user.opinion_favorites.find_by(opinion_id: opinion.id)
    opinion_favorite.destroy
    if params[:opinion][:down] == '1'
       redirect_to users_opinions_path
    elsif params[:opinion][:down] == '2'
       redirect_to users_opinion_path(opinion)
    elsif params[:opinion][:down] == '3'
       redirect_to opinions_user_index_users_user_path(opinion)
    elsif params[:opinion][:down] == '4'
       redirect_to opinion_favorites_users_user_path(current_user.id)
    else
       redirect_to users_opinion_path(opinion)
    end
  end

end
