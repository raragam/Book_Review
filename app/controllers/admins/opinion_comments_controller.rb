class Admins::OpinionCommentsController < ApplicationController

  def destroy
    opinion_comment = OpinionComment.find_by(opinion_id: params[:opinion_id], id: params[:id])
    if opinion_comment.destroy
      @opinion = Opinion.find(params[:opinion_id])
      @opinion_comments = @opinion.opinion_comments.order("created_at DESC")
      flash[:notice] = "コメントを削除しました。"
      #redirect_to request.referer
      #render 'destroy.js.erb'
    end
  end

end
