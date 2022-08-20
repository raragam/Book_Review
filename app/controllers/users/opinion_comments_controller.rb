class Users::OpinionCommentsController < ApplicationController

  def create
    opinion = Opinion.find(params[:opinion_id])
    opinion_comment = current_user.opinion_comments.new(opinion_comment_params)
    opinion_comment.opinion_id = opinion.id
    if opinion_comment.save
        flash[:notice] = "コメントを投稿しました。"
        redirect_to users_opinion_path(opinion)
    else
        @opinion = opinion
        @user = @opinion.user
        @opinion_new = Opinion.new
        @opinions = Opinion.all
        @opinion_comment = opinion_comment
        render '/users/opinions/show'
    end
  end

  def destroy
    OpinionComment.find_by(opinion_id: params[:opinion_id], id: params[:id]).destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to request.referer
  end

  private

  def opinion_comment_params
    params.require(:opinion_comment).permit(:opinion_comment)
  end

end
