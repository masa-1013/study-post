class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #勉強記録に紐づいているユーザーのアイコン画像のurlを取得する
  def select_user_image_url()
    User.find(self.user_id).image.thumb.url
  end
end
