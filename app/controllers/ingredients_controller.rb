class IngredientsController < ApplicationController

  def new
    @ingredient = Ingredient.new
  end

  def create
    if Ingredient.where(name: params[:ingredient][:name]).exists?
      flash[:alert] = "その名前の食材はすでに存在しています。"
      redirect_to new_ingredient_path
    else
      @ingredient = Ingredient.new(ingredient_params)

      # 総カロリー計算
      protein_calorie = 4*params[:ingredient][:protein_content].to_f
      fat_calorie = 9*params[:ingredient][:fat_content].to_f
      carbohydrate_calorie = 4*params[:ingredient][:carbohydrate_content].to_f
      total_calorie = protein_calorie + fat_calorie + carbohydrate_calorie

      # 各比率計算
      protein_ratio = 100 * protein_calorie / total_calorie
      fat_ratio = 100 * fat_calorie / total_calorie
      carbohydrate_ratio = 100 * carbohydrate_calorie / total_calorie

      @ingredient.total_calorie = total_calorie
      @ingredient.protein_ratio = protein_ratio
      @ingredient.fat_ratio = fat_ratio
      @ingredient.carbohydrate_ratio = carbohydrate_ratio
      if @ingredient.save
        redirect_to ingredients_path
      else
        redirect_to new_ingredient_path
        flash[:alert] = "すべての項目を正しく入力してください。"
      end
    end
  end

  def index
    @ingredients = Ingredient.all.order(created_at: "DESC")
  end

  def show
    @intake_ingredient = IntakeIngredient.new
    @ingredient = Ingredient.find(params[:id])
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])

    # 総カロリー計算
    protein_calorie = 4*params[:ingredient][:protein_content].to_f
    fat_calorie = 9*params[:ingredient][:fat_content].to_f
    carbohydrate_calorie = 4*params[:ingredient][:carbohydrate_content].to_f
    total_calorie = protein_calorie + fat_calorie + carbohydrate_calorie

    # 各比率計算
    protein_ratio = 100 * protein_calorie / total_calorie
    fat_ratio = 100 * fat_calorie / total_calorie
    carbohydrate_ratio = 100 * carbohydrate_calorie / total_calorie

    @ingredient.total_calorie = total_calorie
    @ingredient.protein_ratio = protein_ratio
    @ingredient.fat_ratio = fat_ratio
    @ingredient.carbohydrate_ratio = carbohydrate_ratio
    if @ingredient.update(ingredient_params)
      redirect_to ingredients_path
    else
      redirect_to edit_ingredient_path(@ingredient)
      flash[:alert] = "すべての項目を正しく入力してください。"
    end
  end

  def destroy
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(
      :name,
      :total_calorie,
      :protein_ratio,
      :fat_ratio,
      :carbohydrate_ratio,
      :protein_content,
      :fat_content,
      :carbohydrate_content)
  end
end
