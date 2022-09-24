class Users::RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    #redirect_to request.referer
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
    #redirect_to request.referer
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.order(id: "DESC").page(params[:page]).per(5)
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.order(id: "DESC").page(params[:page]).per(5)
  end
end
