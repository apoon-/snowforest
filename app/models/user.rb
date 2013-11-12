class User < ActiveRecord::Base

  mount_uploader :avatar, AvatarUploader

  has_secure_password

  has_many :reviews
  has_many :products, :through => :reviews

  validates_presence_of :name

end
