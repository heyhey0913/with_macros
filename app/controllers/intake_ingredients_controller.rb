class IntakeIngredientsController < ApplicationController

  def create
    intake_ingredient = IntakeIngredient.new(intake_ingredient_params)
    intake_ingredient.user_id = current_user.id

    if intake_ingredient.save
      flash[:notice] = "カロリー摂取記録を追加しました。"
      redirect_to intake_logs_path
    else
      flash[:alert] = "食材を追加できませんでした。必要情報を正しく入力してください。"
      redirect_to new_intake_log_path
    end
  end

  def edit
    @intake_ingredients = IntakeIngredient.find(params[:id])
  end

  def update
  end

  def destroy
    @intake_ingredient = IntakeIngredient.find(params[:id])
    @intake_ingredient.destroy
    redirect_to intake_logs_path
    flash[:notice] = "カロリー摂取記録を削除しました"
  end

  private
  def intake_ingredient_params
    params.require(:intake_ingredient).permit(
      :user_id,
      :ingredient_id,
      :weight,
      :recorded_on
      )
  end

end
