class Users::OpinionFavoritesController < ApplicationController

  def create
    opinion = Opinion.find(params[:opinion_id])
    opinion_favorite = current_user.opinion_favorites.new(opinion_id: opinion.id)
    opinion_favorite.save

    redirect_to users_opinion_path(opinion)
  end

  def destroy
    opinion = Opinion.find(params[:opinion_id])
    opinion_favorite = current_user.opinion_favorites.find_by(opinion_id: opinion.id)
    opinion_favorite.destroy
    redirect_to users_opinion_path(opinion)
  end

end
