class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: true
  
  has_many :studies
  has_many :comments
  has_many :relationships, foreign_key:"follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key:"followed_id", class_name:"Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_one_attached :image

  #ユーザーをフォローしているかどうか判定
  def following?(current_user)
    current_user.relationships.find_by_followed_id(self.id)
  end  

  def followed_count
    self.followed_users.count
  end

  def followers_count
    self.followers.count
  end

  #ユーザーのアイコンが存在する時、それを返し
  #なければデフォルト画像を返す
  def return_user_image
    return self.image.attached? ? self.image : EasySettings.default_user_image
  end

  def create_chart_data(date)
    pie_chart_data = {}
    column_chart_data = {}

    period = calculate_period(date)
    #グラフの範囲を元にデータを取得し、グラフ用データを作成
    period.each do |date|
      studies = get_studies_period(date[0], date[1], self.id)
      column_x_axis = convert_date_to_chartdate(date[0])
      column_chart_data[column_x_axis] = 0
      fetch_studies_to_chart_data(studies, 
        column_x_axis, column_chart_data, pie_chart_data)
    end
    #pie_chartを値の大きい順でソート
    pie_chart_data = pie_chart_data.sort_by { |key, value| value }.reverse.to_h
    return column_chart_data, pie_chart_data
  end

  private

  #ある期間の勉強記録を取得する
  def get_studies_period(start_time, end_time, user_id)
    Study.where("user_id = ? and date
       >= ? and date <= ?", user_id, start_time, end_time)
  end

  #取得した勉強記録をチャート用データにする
  def fetch_studies_to_chart_data(studies, date,column_chart_data, pie_chart_data)
    studies.each do |study|
      name = Combmaster.select_tag_name(study.tag)
      time = get_time_hour(study.time)

      column_chart_data[date] += time
      if pie_chart_data.has_key?(name)
        pie_chart_data[name] += time
      else
        pie_chart_data[name] = time
      end
    end
  end

  #勉強記録の期間を計算する
  def calculate_period(date)
    period = []
    today = Date.today
    base_date = Date::new(today.year, today.month, 1)

    (0..6).reverse_each do |i|
      if date == "week"
        end_time = today - 7 * i
        start_time = end_time - 6
      elsif date == "month"
        start_time = base_date.ago(i.month)
        end_time = base_date.ago(i.month).since(1.month) - 1
      else
        start_time = today - i
        end_time = start_time
      end
      period << [change_date_format_to_search_DB(start_time), 
        change_date_format_to_search_DB(end_time)]
    end
    return period
  end

  #日付のフォーマットをDBに合わせる
  def change_date_format_to_search_DB(date)
    date.strftime("%Y-%m-%d")
  end

  #timeの時間部分を数字にして返す
  def get_time_hour(time)
    hour = time.strftime("%H").to_i
    min = time.strftime("%M").to_f
    hour + (min/60).round(1)
  end

  #日付を棒グラフのX軸の項目用に加工する
  def convert_date_to_chartdate(date)
    date_array = date.split("-")
    "#{date_array[1]}月#{date_array[2]}日"
  end
end
