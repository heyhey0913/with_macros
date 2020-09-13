class IntakeRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  with_options presence: true do
    validates :user_id
    validates :recipe_id
    validates :number
    validates :recorded_on
  end

end
