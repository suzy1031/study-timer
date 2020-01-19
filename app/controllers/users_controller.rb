class UsersController < ApplicationController

  def show
    @start_day = StartDay.where(user_id: current_user.id)
    @count_time = CountTime.where(user_id: current_user.id).order('created_at DESC').limit(5)
    @count_hour = @count_time.sum(:count_hour)
    # 平日と休日の勉強時間をハッシュでセットする
    @day_of_week = {:weekday => 3, :holiday => 8}
    # 継続日数メソッド
    continued = CountTime.where(user_id:current_user.id)
    @duration_days = 0

    if continued.select("id").where(created_at: 0.day.ago.all_day).blank?
        i = 1
    else
        i = 0
    end

    while continued.length do
      unless continued.select("id").where(created_at: i.day.ago.all_day).blank?
        @duration_days += 1
        i += 1
      else
        countinuedExit = false
      end
      if countinuedExit == false
        break
      end
    end
    # 年毎に合計するメソッド
    @a_year_counts = CountTime.where(user_id: current_user.id).group("YEAR(created_at)").sum(:count_hour)
    # 1週間の合計count_hourを計算するメソッド
    @a_week_counts = CountTime.where(user_id: current_user.id).where(created_at: 1.week.ago.end_of_day..Time.zone.now.end_of_day).sum(:count_hour)
    # 1週間の目標count_hourを計算するメソッド
    @total_study_time_in_week = (@day_of_week[:weekday] * 5) + (@day_of_week[:holiday] * 2)
    # パーセント表示するメソッド
    @percent_in_week = @a_week_counts.to_f / @total_study_time_in_week.to_f * 100
    # Jsに変数を渡すメソッド
    gon.percent_in_week = @percent_in_week
    # 昨日の学習時間を計算するメソッド
    @yesterday = CountTime.where(user_id: current_user.id).where("DATE(created_at) = ?", Date.today-1)
    # 初期値リセット
    @yesterday_study_hour = 0
    # @yesterday_study_hourに昨日の学習時間の合計を足すメソッド
    @yesterday.each do |study|
      @yesterday_study_hour += study.count_hour
    end
  end
end
