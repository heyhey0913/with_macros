class IntakeLog < ApplicationRecord

	with_options presence: true do
		validates :user_id
		validates :total_calorie
		validates :total_protein
		validates :total_fat
		validates :total_carbohydrate
	end
end
