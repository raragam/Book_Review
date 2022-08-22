class Users::UsersController < ApplicationController

  def index
    @opinion = Opinion.new
    @user = User.new
    @users = User.all
    @user = current_user
  end

  def opinions_user_index
    @opinions = Opinion.where(user_id: params[:id])
  end

  def reviews_user_index
    @reviews = Review.where(user_id: params[:id])
  end

  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.user_id = current_user.id
    @opinion.save
    flash[:notice] = "投稿しました。"
    redirect_to users_opinion_path(@opinion.id)
  end

  def show
    @user = User.find(params[:id])
    @opinion_new = Opinion.new
    @opinions = @user.opinions
    @reviews = @user.reviews
  end

  def edit
    @user = User.find(params[:id])
    redirect_to users_user_path(current_user.id) unless @user == current_user
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "会員情報を編集しました。"
      sign_in(@user, bypass: true)
      redirect_to users_user_path(@user.id)
    else
      render :edit
    end
  end

  def opinion_favorites
    @user = User.find(params[:id])
    opinion_favorites = OpinionFavorite.where(user_id: @user.id).pluck(:opinion_id)
    @favorite_opinions = Opinion.find(opinion_favorites)
    @opinions = OpinionFavorite.all
  end

  def review_favorites
    @user = User.find(params[:id])
    review_favorites = ReviewFavorite.where(user_id: @user.id).pluck(:review_id)
    @favorite_reviews = Review.find(review_favorites)
    @reviews = ReviewFavorite.all
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to about_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email, :password, :password_confirmation, :message)
  end
end
