class RecipeIngredientsController < ApplicationController

  def create
    recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)

    recipes = Recipe.where(user_id: current_user.id)
    latest_recipe = recipes.last
    recipe_ingredient.recipe_id = latest_recipe.id

    if recipe_ingredient.save
      flash[:notice] = "#{recipe_ingredient.ingredient.name}を追加しました。"
    else
      flash[:alert] = "食材を追加できませんでした。グラム数を正しく入力してください。"
    end
    redirect_to new_recipe_path
  end

  def update
    recipe_ingredient = RecipeIngredient.find(params[:id])
    if recipe_ingredient.update(recipe_ingredient_params)
      flash[:notice] = "#{recipe_ingredient.ingredient.name}のグラム数を変更しました。"
      redirect_to new_recipe_path
    else
      flash[:alert] = "入力された値は正しくありません。もう一度やり直してください。"
      redirect_to new_recipe_path
    end
  end

  def destroy
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    flash[:notice] = "#{@recipe_ingredient.ingredient.name}を削除しました"
    @recipe_ingredient.destroy
    redirect_to new_recipe_path
  end

  private

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(
      :recipe_id,
      :ingredient_id,
      :weight
      )
  end

end
