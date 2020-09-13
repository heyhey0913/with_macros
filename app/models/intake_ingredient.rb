class IntakeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :user

  with_options presence: true do
    validates :user_id
    validates :ingredient_id
    validates :weight
    validates :recorded_on
  end

end
