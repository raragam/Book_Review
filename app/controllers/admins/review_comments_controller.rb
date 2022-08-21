class Admins::ReviewCommentsController < ApplicationController

  def destroy
    ReviewComment.find_by(review_id: params[:review_id], id: params[:id]).destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to request.referer
  end

end
