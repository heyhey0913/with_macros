class RecipesController < ApplicationController

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)

	end

	def index
	end

	def show

	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def recipe_params
		params.require(:recipe).permit(:initial_weight, :target_weight, :current_weight, :active_factor, :body_fat,
										:day_limit_protein, :day_limit_fat, :day_limit_carbohydrate)
	end
end
