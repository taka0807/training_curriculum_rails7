class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def getWeek
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)
# テーブルplanの中の今日から＋6日間のデータを抜き取る。plansに代入。
    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
      # 7回繰り返す。pushは[]に押し込む。 plan plan はplanの中のplan（出産）をtoday_planに入れる。
      # plan.dataは出産の日日付。と = だった場合、[]にpushで入れ込む。today_planに。

     wday_num = Date.today.wday
     if wday_num >= 7
      wday_num = wday_num -7
     end
      days = { :month => (@todays_date + x).month, :date => (@todays_date+x).day, :plans => today_plans, :wday=> Date.today.wday}
      @week_days.push(days)
# これも繰り返し処理。7回。= { :month => (@todays_date + x).month, :date => (@todays_date+x).day, :plans => today_plans, :wday=> }　={はハッシュ　.manthは ～の9月。
  # daysの7個の情報をpush → @week_daysに、28行目の[]に押し込んでいる。
    end
  end
end


# [{month=>9,date,17,plans=>[]},{month=>9,date,18,plans=>[]}{month=>9,date,19,plans=>[]}{month=>9,date,20,plans=>[出産]}{month=>9,date,21,plans=>[]}{month=>9,date,22,plans=>[]}{month=>9,date,23,plans=>[]}]