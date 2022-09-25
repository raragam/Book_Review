class Admins::ReviewCommentsController < ApplicationController

  def destroy
    review_comment = ReviewComment.find_by(review_id: params[:review_id], id: params[:id])
    if review_comment.destroy
       @review = Review.find(params[:review_id])
       @review_comments = @review.review_comments.order("created_at DESC")
       flash[:notice] = "コメントを削除しました。"
       #redirect_to request.referer
    end
  end

end
