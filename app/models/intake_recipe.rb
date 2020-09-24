class IntakeRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :intake_date

  with_options presence: true do
    validates :intake_date_id
    validates :recipe_id
    validates :number
  end

end
