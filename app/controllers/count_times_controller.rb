class CountTimesController < ApplicationController

  def new
    @count_time = CountTime.new
  end

  def create
    @count_time = CountTime.create(count_time_params)
    if @count_time.save
      redirect_to :root
    else
      render :new
    end
  end

  private

  def count_time_params
    params.require(:count_time).permit(:count_hour).merge(user_id: current_user.id)
  end
end
