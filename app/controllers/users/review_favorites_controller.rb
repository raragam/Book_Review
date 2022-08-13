class Users::ReviewFavoritesController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    review_favorite = current_user.review_favorites.new(review_id: review.id)
    review_favorite.save
    redirect_to users_review_path(review)
  end

  def destroy
    review = Review.find(params[:review_id])
    review_favorite = current_user.review_favorites.find_by(review_id: review.id)
    review_favorite.destroy
    redirect_to users_review_path(review)
  end
end
