class ProgressLog < ApplicationRecord

  validates :weight,  presence: true
  validates :recorded_on,  presence: true, uniqueness: true

  attachment :body_image

end
