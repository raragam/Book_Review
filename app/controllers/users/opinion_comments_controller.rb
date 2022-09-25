class Users::OpinionCommentsController < ApplicationController

  def create
    opinion = Opinion.find(params[:opinion_id])
    opinion_comment = current_user.opinion_comments.new(opinion_comment_params)
    opinion_comment.opinion_id = opinion.id
    if opinion_comment.save
        @opinion = opinion
        @opinions = Opinion.all
        @opinion_comment = opinion_comment
        @opinion_comments = @opinion.opinion_comments.order("created_at DESC").page(params[:page]).per(5)
        @user = @opinion.user
        flash.now[:notice] = "コメントを投稿しました。"
        #render 'create.js.erb'
    else
        @opinion = opinion
        @opinions = Opinion.all
        @opinion_comment = opinion_comment
        @opinion_comments = @opinion.opinion_comments.order("created_at DESC").page(params[:page]).per(5)
        @opinion_new = Opinion.new
        @user = @opinion.user
        render 'error'
    end
  end

  def destroy
    opinion_comment = OpinionComment.find_by(opinion_id: params[:opinion_id], id: params[:id])
    if opinion_comment.destroy
      @opinion = Opinion.find(params[:opinion_id])
      @opinion_comments = @opinion.opinion_comments.order("created_at DESC").page(params[:page]).per(5)
      flash.now[:notice] = "コメントを削除しました。"
      #redirect_to request.referer
      #render 'destroy.js.erb'
    end
  end

  private

  def opinion_comment_params
    params.require(:opinion_comment).permit(:opinion_comment)
  end

end