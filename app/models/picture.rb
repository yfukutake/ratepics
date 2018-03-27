class Picture < ApplicationRecord
  before_destroy :clean_s3
  belongs_to :user
  
  validates :user_id, presence:true
  validates :image, presence:true
  mount_uploader :image, ImageUploader
  
  has_many :evaluations, dependent: :destroy
  has_many :users
  
  private
    def clean_s3
      image.remove!
      image.thumb.remove!
    rescue Excon::Errors::Error => error
      puts "Something gone wrong"
      false
    end
end
