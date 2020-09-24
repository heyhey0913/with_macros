class IntakeIngredientsController < ApplicationController
  before_action :authenticate_user!

  def create
    @intake_date = current_user.intake_dates.find_by(recorded_on: params[:recorded_on])
    intake_date_exist

    intake_ingredient = IntakeIngredient.new
    intake_ingredient.intake_date_id = @intake_date.id
    intake_ingredient.ingredient_id = params[:ingredient_id]
    intake_ingredient.weight = params[:weight]

    if intake_ingredient.save
      flash[:notice] = "カロリー摂取記録を追加しました。"
      redirect_to intake_logs_path
    else
      flash[:alert] = "食材を追加できませんでした。必要情報を正しく入力してください。"
      redirect_to ingredient_path(params[:ingredient_id])
    end
  end

  def edit
    @intake_ingredients = IntakeIngredient.find(params[:id])
  end

  def update
  end

  def destroy
    @intake_ingredient = IntakeIngredient.find(params[:id])
    intake_date = @intake_ingredient.intake_date

    @intake_ingredient.destroy

    if intake_date.intake_ingredients.blank? && intake_date.intake_recipes.blank?

      redirect_to intake_logs_path
      flash[:notice] = "#{intake_date.recorded_on.strftime('%Y/%m/%d')}の記録は全て削除されました。"
      intake_date.destroy
    else
      redirect_to intake_log_path(intake_date)
      flash[:notice] = "カロリー摂取記録を削除しました"
    end
  end

  private

  def intake_date_exist
    if @intake_date.blank?
      @intake_date = IntakeDate.new
      @intake_date.recorded_on = params[:recorded_on]
      @intake_date.user_id = current_user.id

      @intake_date.save
    end
  end

end
