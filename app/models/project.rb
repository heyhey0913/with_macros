class Project < ApplicationRecord

	attribute :active_factor, :float, default: 1.2
	attribute :fat_intake_ratio, :integer, default: 20

	belongs_to :user

   with_options presence: true do
		validates :initial_weight
		validates :target_weight
		validates :current_weight
		validates :active_factor
		validates :body_fat
		validates :weekly_target_weight
		validates :dairy_target_calorie
		validates :protein_intake_ratio
		validates :fat_intake_ratio
		validates :carbohydrate_intake_ratio
	end

	def lean_body_mass
		self.current_weight * (1 - self.body_fat.to_f/100)
	end

	def basal_metabolic_rate
		370 + 21.6 * self.lean_body_mass
	end

	def maintenance_calorie
		self.basal_metabolic_rate * self.active_factor
	end

	def calculate_dairy_target_calorie
		self.maintenance_calorie - 1000 * self.weekly_target_weight
	end

end
