class Admins::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def user_opinion_index
    @opinions = Opinion.where(user_id: params[:id])
  end

  def user_review_index
    @reviews = Review.where(user_id: params[:id])
  end

  def show
    @user = User.find(params[:id])
    @opinions = @user.opinions
    @reviews = @user.reviews
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to admins_user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email, :password, :password_confirmation, :is_deleted)
  end

end
