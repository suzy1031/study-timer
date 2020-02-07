class UsersController < ApplicationController

  def show
    @start_day = StartDay.where(user_id: current_user.id)
    # ログインユーザーのレコードを取得する
    @current_user = CountTime.where(user_id: current_user.id)
    @count_time = @current_user.get_user_time_desc_5
    @count_hour = @count_time.sum(:count_hour)
    # 昨日の学習時間を計算するメソッド
    @yesterday = @current_user.get_yesterday_hour
    # 初期値リセット
    @yesterday_study_hour = 0
    # @yesterday_study_hourに昨日の学習時間の合計を足すメソッド
    @yesterday.each do |study|
      @yesterday_study_hour += study.count_hour
    end
    @word = {:nonClear => "今日は頑張りましょう !", :clear => "目標達成!"}
    # 平日と休日の勉強時間をハッシュでセットする
    @day_of_week = {:weekday => 3, :holiday => 8}
    @weekday_result = @day_of_week[:weekday] - @yesterday_study_hour
    @holiday_result = @day_of_week[:holiday] - @yesterday_study_hour
  end

  def a_year_counts
    # 年毎に合計するメソッド
    # 戻り値はハッシュ
    @a_year_counts = @current_user.group("YEAR(created_at)").sum(:count_hour)
  end

  def performance_this_year
    # 今年の合計時間を計算するメソッド
    this_year_performance = @current_user.where(created_at: Date.today.all_month).sum(:count_hour)
    # this_month_count = Date.today.all_month.count
    # total_study_time_in_week = (@day_of_week[:weekday] * 5) + (@day_of_week[:holiday] * 2)
    # this_year_goal = total_study_time_in_week * 4.4
    return "今月の目標は#{this_year_performance}/100時間"
  end

  def last_week_counts
    # 先週1週間の合計count_hourを計算するメソッド
    @last_week_counts = @current_user.get_last_monday_to_sunday
  end

  def percent_in_week
    # 今週1週間の合計count_hourを計算するメソッド
    @a_week_counts = @current_user.get_percent_this_week
    # 1週間の目標count_hourを計算するメソッド
    @total_study_time_in_week = (@day_of_week[:weekday] * 5) + (@day_of_week[:holiday] * 2)
    @percent_in_week = @a_week_counts.to_f / @total_study_time_in_week.to_f * 100
    gon.percent_in_week = @percent_in_week
  end

  def this_week_counts
    return "#{@a_week_counts} / #{@total_study_time_in_week}"
  end

  def duration_days
    # 継続日数メソッド
    continued = @current_user
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
    return @duration_days
  end

  def saturday_goal
    # @weekday_result = @day_of_week[:weekday] - @yesterday_study_hour
    if @yesterday_study_hour >= @day_of_week[:weekday]
      "今日の学習時間は#{@day_of_week[:holiday]}時間です！#{@word[:clear]}"
    else
      "今日の学習時間は#{@day_of_week[:holiday]}時間です！昨日は#{@weekday_result}時間足りませんでした！#{@word[:nonClear]}"
    end
  end

  def sunday_goal
    # @holiday_result = @day_of_week[:holiday] - @yesterday_study_hour
    if @yesterday_study_hour >= @day_of_week[:holiday]
      "今日の学習時間は#{@@day_of_week[:holiday]}時間です！#{@word[:clear]}"
    else
      "今日の学習時間は#{@day_of_week[:holiday]}時間です！昨日は#{@holiday_result}時間足りませんでした！#{@word[:nonClear]}"
    end
  end

  def monday_goal
    # @holiday_result = @day_of_week[:holiday] - @yesterday_study_hour
    if @yesterday_study_hour >= @day_of_week[:holiday]
      "今日の学習時間は#{@@day_of_week[:weekday]}時間です#{@word[:clear]}"
    else
      "今日の学習時間は#{@day_of_week[:weekday]}時間です！昨日は#{@holiday_result}時間足りませんでした！#{@word[:nonClear]}"
    end
  end

  def otherDay_goal
    # @weekday_result = @day_of_week[:weekday] - @yesterday_study_hour
    if @yesterday_study_hour >= @day_of_week[:weekday]
      "今日の学習時間は#{@day_of_week[:weekday]}時間です！#{@word[:clear]}"
    else
      "今日の学習時間は#{@day_of_week[:weekday]}時間です！昨日は#{@weekday_result}時間足りませんでした！#{@word[:nonClear]}"
    end
  end
end
