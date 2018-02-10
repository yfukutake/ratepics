class Picture < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence:true
  validates :image, presence:true
  mount_uploader :image, ImageUploader
end
