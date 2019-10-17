class Study < ApplicationRecord
  validate :validate_time_not_zero

  belongs_to :user
  has_many :comments
  
  #タイムラインに表示する勉強記録の取得
  def self.select_public_studies
    Study.joins("inner join users on studies.user_id = 
      users.id and users.public = true").select("studies.*, users.name, users.image").order(updated_at: :desc)
  end

  #フォローに表示する勉強記録の取得
  def self.select_followed_studies(current_user)
    Study.joins("inner join users on studies.user_id = 
      users.id").select("studies.*, users.name, users.image").
      where("studies.user_id IN (#{current_user.followed_user_ids.push(current_user.id).join(',')})").order(updated_at: :desc)
  end

  #コメント情報をユーザー名付きで取得する
  def select_comments_and_user_name
    Comment.joins("inner join users on users.id =
      comments.user_id").select("comments.*, users.name").where("comments.study_id = ?", self.id).order(created_at: :desc)
  end

  #勉強記録詳細を表示しても良いか(urlの直打ち対策)
  def can_show_study(current_user)
    return true if self.user == current_user
    return true if self.user.public
    false
  end

  #勉強記録からユーザー名を取得する
  def select_username_from_study_user_id()
    return User.find(self.user_id).name
  end

  private

  def validate_time_not_zero
    errors.add(:time, "を入力してください") if time.strftime("%H:%M") == "00:00"
  end
end
