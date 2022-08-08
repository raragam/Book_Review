class Users::UsersController < ApplicationController
  def index
    @opinion = Opinion.new
    @user = User.new
    @users = User.all
    @user = current_user
  end

  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.user_id = current_user.id
    @opinion.save
    redirect_to opinion_path(@opinion.id)
  end

  def show
    @user = User.find(params[:id])
    @user_my = current_user
    @opinion_new = Opinion.new
    @opinions = @user.opinions
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless @user == current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email, :password, :password_confirmation)
  end
end
