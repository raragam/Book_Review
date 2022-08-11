class Users::ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    review = Review.new(review_params)
    review.user_id = current_user.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    review.save

    # 詳細画面へリダイレクト
    redirect_to users_review_path(review.id)

    #render :new

  end

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to users_review_path(review.id)
  end

  def destroy
    review = Review.find(params[:id])  # データ（レコード）を1件取得
    review.destroy  # データ（レコード）を削除
    redirect_to '/users/reviews'  # 投稿一覧画面へリダイレクト
  end

  private
  # ストロングパラメータ
  def review_params
    params.require(:review).permit(:review_title, :review_body, :image)
  end

end
