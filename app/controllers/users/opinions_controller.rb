class Users::OpinionsController < ApplicationController
  def index
    @opinion = Opinion.new
    @opinions = Opinion.all
    @user = current_user
  end

  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.user_id = current_user.id
    if @opinion.save
    flash[:notice] = "You have created opinion successfully."
    redirect_to opinion_path(@opinion.id)
    else
    @opinions = Opinion.all
    @user = current_user
    render :index
    end
  end

  def show
    @opinion = Opinion.find(params[:id])
    @user = @opinion.user
    @opinion_new = Opinion.new
    @opinions = Opinion.all
  end

  def edit
    @opinion = Opinion.find(params[:id])
    redirect_to opinions_path unless current_user.id == @opinion.user_id
  end

  def update
    @opinion = Opinion.find(params[:id])
    if @opinion.update(opinion_params)
      flash[:notice] = "You have updated opinion successfully."
      redirect_to opinion_path(@opinion.id)
    else
      @opinions = Opinion.all
      render :edit
    end
  end

  def destroy
    @opinion = Opinion.find(params[:id])
    @opinion.destroy
    redirect_to '/opinions'
  end

  private

  def opinion_params
    params.require(:opinion).permit(:opinion_title, :opinion_body)
  end
end
