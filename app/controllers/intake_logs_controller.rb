class IntakeLogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @intake_dates = current_user.intake_dates.order(recorded_on: "DESC")
  end

  def show
    @intake_date = IntakeDate.find(params[:id])

    @daily_total_calorie = 0
    @daily_total_protein = 0
    @daily_total_fat = 0
    @daily_total_carbohydrate = 0

    @intake_date.intake_recipes.each do |ir|
      @daily_total_calorie += (ir.recipe.total_calorie * ir.number).round
      @daily_total_protein += (ir.recipe.protein_content * ir.number).round
      @daily_total_fat += (ir.recipe.fat_content * ir.number).round
      @daily_total_carbohydrate += (ir.recipe.carbohydrate_content * ir.number).round
    end

    @intake_date.intake_ingredients.each do |ii|
      @daily_total_calorie += (ii.ingredient.total_calorie * ii.weight/100).round
      @daily_total_protein += (ii.ingredient.protein_content * ii.weight/100).round
      @daily_total_fat += (ii.ingredient.fat_content * ii.weight/100).round
      @daily_total_carbohydrate += (ii.ingredient.carbohydrate_content * ii.weight/100).round
    end
  end

end
