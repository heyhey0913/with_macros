class IntakeRecipesController < ApplicationController

  def create
    intake_recipe = IntakeRecipe.new(intake_recipe_params)
    intake_recipe.user_id = current_user.id

    if intake_recipe.save
      flash[:notice] = "カロリー摂取記録を追加しました。"
      redirect_to intake_logs_path
    else
      flash[:alert] = "食材を追加できませんでした。必要情報を正しく入力してください。"
      redirect_to new_intake_log_path
    end
  end

  def edit
    @intake_recipes = IntakeRecipe.find(params[:id])
  end

  def update
  end

  def destroy
    @intake_recipe = IntakeRecipe.find(params[:id])
    @intake_recipe.destroy
    redirect_to intake_logs_path
    flash[:notice] = "カロリー摂取記録を削除しました"
  end

  private
  def intake_recipe_params
    params.require(:intake_recipe).permit(
      :user_id,
      :recipe_id,
      :number,
      :recorded_on
      )
  end


end
