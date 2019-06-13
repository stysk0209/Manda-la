class MandalasController < ApplicationController

  def top
      gon.registfail = regist_params[:regist]
      gon.log_in_fail = log_in_params[:log_in]
  end

  def about
  end

  def new
    @user = current_user
    @user.mandalas.build
    gon.section = 1 #jQuery分岐用
    @section = 1 #view分岐用
    @center_text = "達成したい目標"
    @around_text = "必要な要素"
  end

  def new_step2
    @user = current_user
    @user.mandalas.build
    @mandala_center = Mandala.find_by(user_id: current_user.id, parent_id: nil)
    gon.section = 2
    @center_text = "達成したい目標"
    @around_text = "必要な要素"
    render 'mandalas/new'
  end

  def create
    mandala = current_user.mandalas.build(user_params[:mandalas_attributes]["4"])
    if mandala.save
      redirect_to mandala_new_step2_path
    else
      redirect_to new_mandala_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,
                    mandalas_attributes: [:user_id,:parent_id, :target, :achieved, :_destroy])
  end

  # ユーザー認証失敗時のパラメーターチェック
  def regist_params
    params.permit(:regist)
  end

  def log_in_params
    params.permit(:log_in)
  end

end
