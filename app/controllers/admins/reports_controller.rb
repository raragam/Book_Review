class Admins::ReportsController < ApplicationController

  def index
    @reports = Report.all.order(id: "DESC")
  end

  def show
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
       flash[:notice] = "対応ステータスを更新しました。"
       redirect_to request.referer
    else
       render :show
    end
  end

  private

  def report_params
    params.require(:report).permit(:status)
  end

end
