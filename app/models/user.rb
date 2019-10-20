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
  #カラムの名前をmount_uploaderに指定
  #mount_uploader :image, ImageUploader

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
end
