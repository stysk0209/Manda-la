class MandalasController < ApplicationController

  def top
      gon.registfail = regist_params[:regist]
      gon.log_in_fail = log_in_params[:log_in]
  end

  def about
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  # ユーザー認証失敗時のパラメーターチェック
  def regist_params
    params.permit(:regist)
  end

  def log_in_params
    params.permit(:log_in)
  end

end
