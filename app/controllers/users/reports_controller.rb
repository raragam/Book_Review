class Users::ReportsController < ApplicationController

  def new
    @report = Report.new #新しい通報の箱を用意
    @user = User.find(params[:user_id]) #どのユーザーに対する通報なのかparamsで取得する
  end

  def create
    @user = User.find(params[:user_id])
    @report = Report.new(report_params) #どのユーザーに対する通報なのかparamsで取得する
    @report.reporter_id = current_user.id #通報者(reporter_id)にcurrent_user.idを代入
    @report.reported_id = @user.id #通報される人(reported_id)に上で取得した@user.idを代入
    if @report.save #保存する
      redirect_to users_user_path(@user), notice: "ご報告ありがとうございます。"
    else
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason, :url)
  end

end
