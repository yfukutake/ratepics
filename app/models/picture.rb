class Picture < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence:true
  validates :image, presence:true
  mount_uploader :image, ImageUploader
  
  has_many :evaluations, dependent: :destroy
  has_many :users
end
