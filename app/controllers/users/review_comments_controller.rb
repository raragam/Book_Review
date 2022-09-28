class Users::ReviewCommentsController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    review_comment = current_user.review_comments.new(review_comment_params)
    review_comment.review_id = review.id
    if review_comment.save
       @review = review
       @review_comments = @review.review_comments.order("created_at DESC").page(params[:page]).per(5)
       flash.now[:notice] = "コメントを投稿しました。"
       #render 'create.js.erb'
       #redirect_to review_path(review)
    else
       @review = review
       #@user = @review.user
       @review_comment = review_comment
       @review_comments = @review.review_comments.order("created_at DESC").page(params[:page]).per(5)
       render 'error'
    end
  end

  def destroy
    review_comment = ReviewComment.find_by(review_id: params[:review_id], id: params[:id])
    if review_comment.destroy
       @review = Review.find(params[:review_id])
       @review_comments = @review.review_comments.order("created_at DESC").page(params[:page]).per(5)
       flash.now[:notice] = "コメントを削除しました。"
       #render 'destroy.js.erb'
    end
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:review_comment)
  end

end
