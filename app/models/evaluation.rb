class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :picture
  
  validates :user_id, presence: true
  validates :picture_id, presence: true
  validates :point, numericality: {only_integer: true, greater_than: 0, less_than: 6}
end
