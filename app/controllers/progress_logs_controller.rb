class ProgressLogsController < ApplicationController

  def new
    @progress_log = ProgressLog.new
  end

  def create
    if ProgressLog.where(recorded_on: params[:progress_log][:recorded_on]).exists?
      flash[:alert] = "その日付の経過記録はすでに存在しています。"
      redirect_to new_progress_log_path
    else
      if params[:progress_log][:weight].blank?
        flash[:alert] = "必須項目が入力されていません。"
        redirect_to new_progress_log_path
      else
        @progress_log = ProgressLog.new(progress_log_params)
        @progress_log.user_id = current_user.id

        if @progress_log.save
          # 経過記録の日付が最新の場合、ユーザーの現在値を更新
          current_parameter_update

          flash[:notice] = "経過記録を登録しました。"
          redirect_to users_path
        else
          render :new
        end
      end
    end
  end

  def index
    @progress_logs = current_user.progress_logs.order(recorded_on: "DESC")
  end

  def show
    @progress_log = ProgressLog.find(params[:id])
  end

  def edit
    @progress_log = ProgressLog.find(params[:id])
  end

  def update
    if ProgressLog.where(recorded_on: params[:progress_log][:recorded_on]).exists?
      flash[:alert] = "その日付の経過記録はすでに存在しています。"
      redirect_to edit_progress_log_path(@ingredient)
    else
      if params[:progress_log][:weight].blank?
        flash[:alert] = "必須項目が入力されていません。"
        redirect_to edit_progress_log_path(@ingredient)
      else
        @progress_log = ProgressLog.find(params[:id])
        if @progress_log.update(progress_log_params)
          # 経過記録の日付が最新の場合、ユーザーの現在値を更新
          current_parameter_update
          redirect_to progress_logs_path
          flash[:notice] = "経過記録を更新しました。"
        else
          render "edit"
        end
      end
    end
  end

  def destroy
    @progress_log = ProgressLog.find(params[:id])
    @progress_log.destroy
    redirect_to progress_logs_path
    flash[:notice] = "経過記録を削除しました"
  end

  private
  def progress_log_params
    params.require(:progress_log).permit(
      :user_id,
      :weight,
      :body_fat,
      :body_image,
      :recorded_on
      )
  end

  def current_parameter_update
    progress_logs = current_user.progress_logs.order(recorded_on: "DESC")
    latest_progress_log = progress_logs.first
    if @progress_log.recorded_on == latest_progress_log.recorded_on
      current_user.current_weight = @progress_log.weight
      if @progress_log.body_fat.present?
        current_user.current_body_fat = @progress_log.body_fat
      end
      current_user.save
    end
  end

end
