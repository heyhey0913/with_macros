class IntakeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :intake_date

  with_options presence: true do
    validates :intake_date_id
    validates :ingredient_id
    validates :weight
  end

end
