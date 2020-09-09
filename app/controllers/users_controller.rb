class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
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
    calorie = current_user.calculate_dairy_target_calorie
    current_user.dairy_target_calorie = calorie

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
          :dairy_target_calorie,
          :protein_intake_ratio,
          :fat_intake_ratio,
          :carbohydrate_intake_ratio
        )
    end

end
