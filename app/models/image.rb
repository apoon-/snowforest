class Image < ActiveRecord::Base
  mount_uploader :path, ImageUploader
 
  belongs_to :product
end
