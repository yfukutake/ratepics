class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :pictures
  has_many :evaluations
  has_many :scores, through: :evaluations, source: :picture
  
  def rate(picture)
    evaluations.find_or_create_by(picture_id: picture.id)
  end
  
  def unrated(picture)
    evaluation = evaluations.find_by(picture_id: picture.id)
    evaluation.destroy if evaluation
  end
  
  def rated?(picture)
    scores.include?(picture)
  end
end