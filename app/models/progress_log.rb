class ProgressLog < ApplicationRecord

  validates :weight,  presence: true
  validates :recorded_on,  presence: true, uniqueness: true

  belongs_to :user

  attachment :body_image

end
