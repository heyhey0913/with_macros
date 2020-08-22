class ProjectsController < ApplicationController

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
		@project.user_id = current_user.id
		@project.current_weight = params[:project][:initial_weight]

		# 日々の目標カロリーを計算し、プロジェクトに代入
		calorie = @project.calculate_dairy_target_calorie.round
		@project.dairy_target_calorie = calorie

		#タンパク質摂取割合を計算し、プロジェクトに代入
		protein_magnification = (params[:protein_magnification]).to_f
		protein_intake_content = @project.lean_body_mass * protein_magnification
		protein_intake_ratio = ((400 * protein_intake_content) / calorie).round
		@project.protein_intake_ratio = protein_intake_ratio
		byebug

		#炭水化物質摂取割合を計算し、プロジェクトに代入
		carbohydrate_intake_ratio = 80 - protein_intake_ratio
		@project.carbohydrate_intake_ratio = carbohydrate_intake_ratio

	    if @project.save
		    redirect_to users_path
		else
			redirect_to new_project_path
		end
	end

	def index
		@projects = Project.where(user_id: current_user.id).order(created_at: "DESC")
	end

	def show

	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def project_params
		params.require(:project).permit(:user_id, :initial_weight, :target_weight, :current_weight, :active_factor, :body_fat, :weekly_target_weight,
										:dairy_target_calorie, :protein_intake_ratio, :fat_intake_ratio, :carbohydrate_intake_ratio)
	end
end
