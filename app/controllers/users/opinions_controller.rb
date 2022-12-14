class Users::OpinionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @opinion = Opinion.new
    @opinions = Opinion.all.order(id: "DESC").page(params[:page]).per(5)
    @user = current_user
  end

  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.user_id = current_user.id
    if @opinion.save
       flash[:notice] = "投稿しました。"
       redirect_to opinions_path(@opinion.id)
    else
       @opinions = Opinion.all.order(id: "DESC").page(params[:page]).per(5)
       @user = current_user
       render :index
    end
  end

  def show
    @opinion = Opinion.find(params[:id])
    @user = @opinion.user
    @opinion_new = Opinion.new
    #@opinions = Opinion.all
    @opinion_comment = OpinionComment.new
    @opinion_comments = @opinion.opinion_comments.order("created_at DESC").page(params[:page]).per(5)
    impressionist(@opinion, nil, unique: [:session_hash])
  end

  def edit
    @opinion = Opinion.find(params[:id])
    redirect_to opinion_path unless current_user.id == @opinion.user_id
  end

  def update
    @opinion = Opinion.find(params[:id])
    if @opinion.update(opinion_params)
       flash[:notice] = "投稿を編集しました。"
       redirect_to opinion_path(@opinion.id)
    else
       render :edit
    end
  end

  def destroy
    @opinion = Opinion.find(params[:id])
    @opinion.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to '/opinions'
  end

  private

  def opinion_params
    params.require(:opinion).permit(:opinion_title, :opinion_body)
  end

end