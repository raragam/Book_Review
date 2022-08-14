class Admins::OpinionsController < ApplicationController

  def show
    @opinion = Opinion.find(params[:id])
    @user = @opinion.user
    @opinions = Opinion.all
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
