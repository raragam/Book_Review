class Admins::UsersController < ApplicationController

  def index
    @users = User.all.order(id: "DESC")
  end

  def opinions_user_index
    @opinions = Opinion.where(user_id: params[:id]).order(id: "DESC")
  end

  def reviews_user_index
    @reviews = Review.where(user_id: params[:id]).order(id: "DESC")
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
       flash[:notice] = "#{@user.name}さんの情報を更新しました。"
       redirect_to admins_user_path(@user.id)
    else
       render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email, :password, :password_confirmation, :is_deleted, :message)
  end

end
