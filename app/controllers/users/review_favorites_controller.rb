class Users::ReviewFavoritesController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    review_favorite = current_user.review_favorites.new(review_id: review.id)
    review_favorite.save
    if params[:review][:up] == '1'
       redirect_to users_reviews_path
    elsif params[:review][:up] == '2'
       redirect_to users_review_path(review)
    elsif params[:review][:up] == '3'
       redirect_to reviews_user_index_users_user_path(review)
    elsif params[:review][:up] == '4'
       redirect_to review_favorites_users_user_path(current_user.id)
    else
       redirect_to users_review_path(review)
    end
  end

  def destroy
    review = Review.find(params[:review_id])
    review_favorite = current_user.review_favorites.find_by(review_id: review.id)
    review_favorite.destroy
    if params[:review][:down] == '1'
       redirect_to users_reviews_path
    elsif params[:review][:down] == '2'
       redirect_to users_review_path(review)
    elsif params[:review][:down] == '3'
       redirect_to reviews_user_index_users_user_path(review)
    elsif params[:review][:down] == '4'
       redirect_to review_favorites_users_user_path(current_user.id)
    else
       redirect_to users_review_path(review)
    end
  end
end
