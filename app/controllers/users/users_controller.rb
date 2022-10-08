class Users::UsersController < ApplicationController

  before_action :authenticate_user!, except: [:opinions_user_index, :reviews_user_index]

  def index
    @opinion = Opinion.new
    @user = User.new
    @users = User.all.order(id: "DESC").page(params[:page]).per(5)
    @user = current_user
  end

  def opinions_user_index
    @opinions = Opinion.where(user_id: params[:id]).order(id: "DESC").page(params[:page]).per(5)
    @user = User.find(params[:id])
  end

  def reviews_user_index
    @reviews = Review.where(user_id: params[:id]).order(id: "DESC").page(params[:page]).per(5)
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @opinion_new = Opinion.new
    @opinions = @user.opinions
    @reviews = @user.reviews
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless @user == current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報を編集しました。"
      sign_in(@user, bypass: true)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def opinion_favorites
    #@opinion_favorites = opinion_favorites.order(id: "DESC").page(params[:page]).per(5)
    #@favorite_opinions = Opinion.where(id: opinion_favorites.pluck(:opinion_id)).order(id: "DESC").page(params[:page]).per(5)
    @user = User.find(params[:id])
    opinion_favorites = OpinionFavorite.where(user_id: @user.id)
    favorite_opinions = Opinion.where(id: opinion_favorites.pluck(:opinion_id)).order(id: "DESC")
    @favorite_opinions = favorite_opinions.page(params[:page]).per(5)
    if !@favorite_opinions.any? && params[:page].present?
       params[:page] = params[:page].to_i - 1
       @favorite_opinions = favorite_opinions.page(params[:page]).per(5)
    end
    @opinions = OpinionFavorite.all
  end

  def review_favorites
     #review_favorites = ReviewFavorite.where(user_id: @user.id).order(id: "DESC").page(params[:page]).per(5).pluck(:review_id)
     #@favorite_reviews = Review.find(review_favorites)
     #@reviews = ReviewFavorite.all
    @user = User.find(params[:id])
    review_favorites = ReviewFavorite.where(user_id: @user.id)
    favorite_reviews = Review.where(id: review_favorites.pluck(:review_id)).order(id: "DESC")
    @favorite_reviews = favorite_reviews.page(params[:page]).per(5)
    if !@favorite_reviews.any? && params[:page].present?
       params[:page] = params[:page].to_i - 1
       @favorite_reviews = favorite_reviews.page(params[:page]).per(5)
    end
     #@favorite_reviews = Review.where(id: review_favorites.pluck(:review_id)).order(id: "DESC").page(params[:page]).per(5)
     #params[:page] = params[:page].to_i - 1 if @favorite_reviews.any? && params[:page].present?
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