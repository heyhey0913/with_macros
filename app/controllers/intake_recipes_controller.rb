class IntakeRecipesController < ApplicationController
  before_action :authenticate_user!

  def create
    @intake_date = current_user.intake_dates.find_by(recorded_on: params[:recorded_on])
    intake_date_exist

    intake_recipe = IntakeRecipe.new
    intake_recipe.intake_date_id = @intake_date.id
    intake_recipe.recipe_id = params[:recipe_id]
    intake_recipe.number = params[:number]

    if intake_recipe.save
      flash[:notice] = "カロリー摂取記録を追加しました。"
      redirect_to intake_logs_path
    else
      flash[:alert] = "食材を追加できませんでした。必要情報を正しく入力してください。"
      redirect_to recipe_path(params[:recipe_id])
    end
  end

  def update
    intake_recipe = IntakeRecipe.find(params[:id])
    if intake_recipe.update
      # 経過記録の日付が最新の場合、ユーザーの現在値を更新
      current_parameter_update
      redirect_to intake_logs_path
      flash[:notice] = "摂取量を更新しました。"
    else
      flash[:alert] = "更新に失敗しました。"
      redirect_to intake_logs_path
    end
  end

  def destroy
    @intake_recipe = IntakeRecipe.find(params[:id])
    intake_date = @intake_recipe.intake_date

    @intake_recipe.destroy

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
