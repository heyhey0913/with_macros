class IntakeRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :intake_log
end
