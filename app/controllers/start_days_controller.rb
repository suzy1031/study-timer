class StartDaysController < ApplicationController

  def new
    # Start_day= スネークケースは使用不可
    # Start_day = StartDayキャメルケースに変換
    @start_day = StartDay.new
  end

  def create
    @start_day = StartDay.create(start_day_params)
    if @start_day.save
      redirect_to :root
    else
      render :new
    end
  end

  private

  def start_day_params
    params.require(:start_day).permit(:start_day).merge(user_id: current_user.id)
  end
end
