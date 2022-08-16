class Users::ReviewCommentsController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    review_comment = current_user.review_comments.new(review_comment_params)
    review_comment.review_id = review.id
    if review_comment.save
         redirect_to users_review_path(review)
    else
       @review = review
       @user = @review.user
       @review_comment = review_comment
         render 'users/reviews/show'
    end
  end

  def destroy
    ReviewComment.find_by(review_id: params[:id], id: params[:review_id]).destroy
    redirect_to request.referer
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:review_comment)
  end

end
