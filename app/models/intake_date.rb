class IntakeDate < ApplicationRecord
  belongs_to :user
  has_many :intake_ingredients, dependent: :destroy
  has_many :intake_recipes, dependent: :destroy

  with_options presence: true do
    validates :user_id
    validates :recorded_on
  end

end
