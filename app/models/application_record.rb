class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #ユーザーのアイコンを取得する
  def select_user_image()
    user = User.find(self.user_id)
    return user.image.attached? ? user.image : EasySettings.default_user_image
  end
end
