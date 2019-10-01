class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: true
  
  has_many :studies
  has_many :comments
  #カラムの名前をmount_uploaderに指定
  mount_uploader :image, ImageUploader
end
