class Users::ReviewCommentsController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    review_comment = current_user.review_comments.new(review_comment_params)
    review_comment.review_id = review.id
    if review_comment.save
       flash[:notice] = "コメントを投稿しました。"
       redirect_to review_path(review)
    else
       @review = review
       @user = @review.user
       @review_comment = review_comment
       @review_comments = @review.review_comments.order("created_at DESC").page(params[:page]).per(5)
       render 'users/reviews/show'
    end
  end

  def destroy
    ReviewComment.find_by(review_id: params[:review_id], id: params[:id]).destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to request.referer
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:review_comment)
  end

end
