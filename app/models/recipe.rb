class Recipe < ApplicationRecord

  validates :user_id, presence: true

  has_many :intake_recipes, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  belongs_to :user

  attachment :dish_image

  enum creation_status:{
    食材選択: 0,
    情報入力: 1,
    内容確認: 2,
    作成完了: 3,
  }

end