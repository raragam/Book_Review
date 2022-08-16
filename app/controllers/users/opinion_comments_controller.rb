class Users::OpinionCommentsController < ApplicationController

  def create
    opinion = Opinion.find(params[:opinion_id])
    opinion_comment = current_user.opinion_comments.new(opinion_comment_params)
    opinion_comment.opinion_id = opinion.id
    if opinion_comment.save
        redirect_to users_opinion_path(opinion)
    else
        render 'users/opinions/show'
    end
  end

  def destroy
    OpinionComment.find_by(opinion_id: params[:id], id: params[:opinion_id]).destroy
    redirect_to request.referer
  end

  private

  def opinion_comment_params
    params.require(:opinion_comment).permit(:opinion_comment)
  end

end
