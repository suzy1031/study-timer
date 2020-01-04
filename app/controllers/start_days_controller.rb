class StartDaysController < ApplicationController
  def index
    if user_signed_in?
      @start_day = StartDay.where(user_id: current_user.id)
      @count_time = CountTime.where(user_id: current_user.id).order('updated_at DESC').limit(5)
      @count_hour = @count_time.sum(:count_hour)

      continued = CountTime.where(user_id:current_user.id)
      @Durationdays = 0

      if continued.select("id").where(created_at: 0.day.ago.all_day).blank?
          i = 1
      else
          i = 0
      end

      while continued.length do
        unless continued.select("id").where(created_at: i.day.ago.all_day).blank?
          @Durationdays += 1
          i += 1
        else
          countinuedExit = false
        end
        if countinuedExit == false
          break
        end
      end
    end
  end

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
