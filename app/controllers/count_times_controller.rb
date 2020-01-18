class CountTimesController < ApplicationController
  before_action :set_count_time, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @count_time.user_id == current_user.id
      if @count_time.update(count_time_params)
        redirect_to :root
      else
        render :edit
      end
    end
  end

  def destroy
    if @count_time.destroy
      redirect_to :root
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def count_time_params
    params.require(:count_time).permit(:count_hour).merge(user_id: current_user.id)
  end

  def set_count_time
    @count_time = CountTime.find(params[:id])
  end
end
