class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.where(creation_status: "作成完了",user_id: current_user.id)
    @today_intake = current_user.intake_dates.find_by(recorded_on: Date.today)

    @daily_total_calorie = 0
    @daily_total_protein = 0
    @daily_total_fat = 0
    @daily_total_carbohydrate = 0

    if @today_intake.present?
      @today_intake.intake_recipes.each do |ir|
        @daily_total_calorie += (ir.recipe.total_calorie * ir.number).round
        @daily_total_protein += (ir.recipe.protein_content * ir.number).round
        @daily_total_fat += (ir.recipe.fat_content * ir.number).round
        @daily_total_carbohydrate += (ir.recipe.carbohydrate_content * ir.number).round
      end

      @today_intake.intake_ingredients.each do |ii|
        @daily_total_calorie += (ii.ingredient.total_calorie * ii.weight/100).round
        @daily_total_protein += (ii.ingredient.protein_content * ii.weight/100).round
        @daily_total_fat += (ii.ingredient.fat_content * ii.weight/100).round
        @daily_total_carbohydrate += (ii.ingredient.carbohydrate_content * ii.weight/100).round
      end
    end

    unless current_user.daily_target_calorie.blank?
      @daily_protein_content = (current_user.daily_target_calorie * current_user.protein_intake_ratio/100) / 4
      @daily_fat_content = (current_user.daily_target_calorie * current_user.fat_intake_ratio/100) / 9
      @daily_carbohydrate_content = (current_user.daily_target_calorie * current_user.carbohydrate_intake_ratio/100) / 4
    end
  end

  def show
  end

  def edit
  end

  def update
    # 日々の目標カロリーを計算し、プロジェクトに代入
    current_user.current_weight = params[:user][:current_weight]
    current_user.target_weight = params[:user][:target_weight]
    current_user.current_body_fat = params[:user][:current_body_fat]
    current_user.active_factor = params[:user][:active_factor]
    current_user.weekly_target_weight = params[:user][:weekly_target_weight]
    calorie = current_user.calculate_daily_target_calorie
    current_user.daily_target_calorie = calorie

    #タンパク質摂取割合を計算し、プロジェクトに代入
    protein_magnification = params[:protein_magnification]
    protein_intake_content = current_user.lean_body_mass * protein_magnification.to_f
    protein_intake_ratio = (400 * protein_intake_content) / calorie
    current_user.protein_intake_ratio = protein_intake_ratio.round

    #炭水化物質摂取割合を計算し、プロジェクトに代入
    carbohydrate_intake_ratio = 80 - protein_intake_ratio.round
    current_user.carbohydrate_intake_ratio = carbohydrate_intake_ratio

    if current_user.update(user_params)
      redirect_to users_path
    else
      redirect_to edit_user_path(current_user)
      flash[:alert] = "必須項目を正しく入力してください"
    end
  end

  def leave
  end

  def hide
    current_user.update(is_valid: false)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(
      :nickname,
      :optional_id,
      :profile_image,
      :email,
      :is_valid,
      :target_weight,
      :current_weight,
      :active_factor,
      :current_body_fat,
      :weekly_target_weight,
      :daily_target_calorie,
      :protein_intake_ratio,
      :fat_intake_ratio,
      :carbohydrate_intake_ratio
      )
  end

end
