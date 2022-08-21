class Admins::OpinionCommentsController < ApplicationController

  def destroy
    OpinionComment.find_by(opinion_id: params[:opinion_id], id: params[:id]).destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to request.referer
  end

end
