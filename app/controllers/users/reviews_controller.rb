class Users::ReviewsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def new
    @review = Review.new
  end

  def index
    @reviews = Review.all
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
       flash[:notice] = "記事を投稿しました。"
       redirect_to users_review_path(@review.id)
    else
       render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
    @review_comment = ReviewComment.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
       flash[:notice] = "投稿記事を編集しました。"
       redirect_to users_review_path(@review.id)
    else
       @review.all
       render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    flash[:notice] = "投稿記事を削除しました。"
    redirect_to '/users/reviews'
  end

  private
  def review_params
    params.require(:review).permit(:review_title, :review_body, :book_name, :image)
  end

end
