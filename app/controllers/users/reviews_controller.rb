class Users::ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @review = Review.new(review_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    @review.save!

    # 詳細画面へリダイレクト
    redirect_to users_review_path(@review.id)

    #render :new

  end

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  private
  # ストロングパラメータ
  def review_params
    params.require(:review).permit(:review_title, :review_body)
  end

end
