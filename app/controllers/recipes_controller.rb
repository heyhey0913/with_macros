class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
	before_action :ensure_creating_recipe_exists, only: [:new, :input, :confirm]

	def new
		if @latest_recipe.creation_status == "食材選択"
			@ingredients = Ingredient.all
			@recipe_ingredient = RecipeIngredient.new
			@recipe_ingredients = RecipeIngredient.where(recipe_id: @latest_recipe.id)
	    # 検索用の食材データ
	    # @q = Ingredient.ransack(params[:q])
	    # @searched_ingredients=@q.result(distinct: true)
	  else
			flash[:notice] = "#{@latest_recipe.creation_status}中のレシピがあります。"
			creation_status_is
	  end
	end

	def back_new
	end

	def input
		if @latest_recipe.creation_status == "情報入力"
			@recipe_ingredients = RecipeIngredient.where(recipe_id: @latest_recipe.id)
	  else
			flash[:notice] = "#{@latest_recipe.creation_status}中のレシピがあります。"
			creation_status_is
	  end
	end

	def back_input
	end

	def confirm
		if @latest_recipe.creation_status == "内容確認"
			@recipe_ingredients = RecipeIngredient.where(recipe_id: @latest_recipe.id)
	  else
			flash[:notice] = "#{@latest_recipe.creation_status}中のレシピがあります。"
			creation_status_is
	  end
	end

	def create

	end

	def index
		@recipes = Recipe.where(creation_status: "作成完了") # where(is_published: true)
	end

	def show
    @intake_recipe = IntakeRecipe.new
    @recipe = Recipe.find(params[:id])
	end

	def edit
    @recipe = Recipe.find(params[:id])
	end

	def update
    @recipe = Recipe.find(params[:id])

    if @recipe.creation_status == "食材選択"
    	input_ingredient_information
		else
			@recipe.update(recipe_params)

			# 作成ステータスが作成完了の場合、レシピ詳細画面へ遷移
			if @recipe.creation_status == "作成完了"
				redirect_to recipe_path(@recipe)
			else
				creation_status_is
			end
		end
	end

	def destroy
		@recipe = Recipe.find(params[:id])
		@recipe.destroy
		redirect_to recipes_path
		flash[:notice] = "削除しました"
	end

	private


	def recipe_params
		params.require(:recipe).permit(
			:user_id,
			:dish_name,
			:method,
			:dish_image,
			:total_calorie,
			:protein_ratio,
			:fat_ratio,
			:carbohydrate_ratio,
			:protein_content,
			:fat_content,
			:carbohydrate_content,
			:creation_status,
			:is_published
			)
	end

	def ensure_creating_recipe_exists
		@recipes = Recipe.where(user_id: current_user.id)
		# レシピがまだ一つも投稿されていない場合はレシピを新規作成し食材選択画面にリダイレクト
		unless @recipes.exists?
			recipe = Recipe.new
			recipe.user_id = current_user.id
			recipe.save
			redirect_to new_recipe_path
		# 最新のレシピが作成完了の場合はレシピを新規作成し食材選択画面にリダイレクト
		else
			@latest_recipe = @recipes.last
			if @latest_recipe.creation_status == "作成完了"
				recipe = Recipe.new
				recipe.user_id = current_user.id
				recipe.save
				redirect_to new_recipe_path
			end
		end
	end

	# 最新レシピの制作ステータスに応じてリダイレクト先を変更
	def creation_status_is
		@recipes = Recipe.where(user_id: current_user.id)
		@latest_recipe = @recipes.last
		case @latest_recipe.creation_status
		when "食材選択"
			redirect_to new_recipe_path
		when "情報入力"
			redirect_to input_recipe_path
		when "内容確認"
			redirect_to confirm_recipe_path
		else
			flash[:alert] = "予期しないアクセスを検知しました。"
			redirect_to users_path
		end
	end

	def input_ingredient_information
		recipe_ingredients = RecipeIngredient.where(recipe_id: @recipe.id)
		if recipe_ingredients.blank?
			flash[:alert] = "食材を一つ以上選択してください。"
			redirect_to new_recipe_path
		else
			sum_protein_content = 0
			sum_fat_content = 0
			sum_carbohydrate_content = 0

			recipe_ingredients.each do |recipe_ingredient|
				use_weight = recipe_ingredient.weight/100
				sum_protein_content += recipe_ingredient.ingredient.protein_content*use_weight
				sum_fat_content += recipe_ingredient.ingredient.fat_content*use_weight
				sum_carbohydrate_content += recipe_ingredient.ingredient.carbohydrate_content*use_weight
			end

			sum_total_calorie = 4*sum_protein_content + 9*sum_fat_content + 4*sum_carbohydrate_content

			@recipe.total_calorie = sum_total_calorie
			@recipe.protein_content = sum_protein_content
			@recipe.carbohydrate_content = sum_carbohydrate_content
			@recipe.fat_content = sum_fat_content
			@recipe.protein_ratio = 100*4*sum_protein_content/sum_total_calorie
			@recipe.fat_ratio = 100*9*sum_fat_content/sum_total_calorie
			@recipe.carbohydrate_ratio = 100*4*sum_carbohydrate_content/sum_total_calorie

			@recipe.update(recipe_params)
			creation_status_is
		end
	end

end
