class Admins::ReviewsController < ApplicationController

  def show
    @review = Review.find(params[:id])
    @user = @review.user
    @reviews = Review.all
  end

  def destroy
    @review = Review.find(params[:id])
    @user = @review.user
    @review.destroy
    redirect_to admins_user_path(@user.id)
  end

  private

  def review_params
    params.require(:review).permit(:review_title, :review_body)
  end

end
