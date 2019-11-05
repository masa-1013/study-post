class StatisticsController < ApplicationController
  def index
    @date = params[:date]
    @date = "day" if @date != "week" and @date != "month"
    @study_column_chart, @study_pie_chart = current_user.create_chart_data(@date)
  end
end
