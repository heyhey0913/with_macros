class Ingredient < ApplicationRecord

  with_options presence: true do
    validates :name, uniqueness: true
    validates :total_calorie
    validates :protein_ratio
    validates :fat_ratio
    validates :carbohydrate_ratio
    validates :protein_content
    validates :fat_content
    validates :carbohydrate_content
  end

  has_many :recipe_ingredients
  has_many :intake_ingredients

end
