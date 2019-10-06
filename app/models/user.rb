class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: true
  
  has_many :studies
  has_many :comments
  has_many :relationships, foreign_key:"follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key:"followed_id", class_name:"Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  #カラムの名前をmount_uploaderに指定
  mount_uploader :image, ImageUploader

  #ユーザーをフォローしているかどうか判定
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  #ユーザーをフォローする
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  #フォローを解除する
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
end
