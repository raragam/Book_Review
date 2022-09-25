class Admins::OpinionsController < ApplicationController

  def index
    @opinions = Opinion.all.order(id: "DESC")
  end

  def show
    @opinion = Opinion.find(params[:id])
    @user = @opinion.user
    @opinions = Opinion.all
    @opinion_comments = @opinion.opinion_comments.order("created_at DESC")
  end

  def destroy
    @opinion = Opinion.find(params[:id])
    @user = @opinion.user
    @opinion.destroy
    redirect_to admins_user_path(@user.id)
  end

  private

  def opinion_params
    params.require(:opinion).permit(:opinion_title, :opinion_body)
  end

end
