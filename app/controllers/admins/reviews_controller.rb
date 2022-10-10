class Admins::ReviewsController < ApplicationController

  def index
    @reviews = Review.all.order(id: "DESC")
  end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
    @reviews = Review.all
    @review_comments = @review.review_comments.order("created_at DESC")
    #impressionist(unique: [:session_hash])
  end

  def destroy
    @review = Review.find(params[:id])
    @user = @review.user
    @review.destroy
    flash[:notice] = "投稿記事を削除しました。"
    redirect_to admins_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:review_title, :review_body)
  end

end
