class MandalasController < ApplicationController

  def top
      gon.registfail = regist_params[:regist]
      gon.log_in_fail = log_in_params[:log_in]
  end

  def about
  end

  def new
    if params[:step] == "3"
      new_step3
    elsif params[:step] == "2"
      new_step2
    else
      new_step1
    end
  end

  def create
    if params[:step] == "1"
      create_step1
    elsif params[:step] == "2"
      create_step2
    else
      create_step3
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end





#-------------------- Mandalaチャートnewアクション用 --------------------#

  def new_step1
    @step = 1 #view分岐用
    gon.step = 1 #jQuery分岐用
    @mandala = Mandala.new
    @mandala.elements.build
    text_step1
  end

  def new_step2
    @step = 2 #view分岐用
    gon.step = 2 #jQuery分岐用
    @mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
    @mandala.elements.build
    text_step2
  end

  def new_step3
    @step = 3 #view分岐用
    gon.step = 3 #jQuery分岐用
    @mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
    text_step3
  end

#-------------------- Mandalaチャート作成用 --------------------#

#---------------- Mandalaチャート作成ページ viewの分岐用 ----------------#

  def text_step1
    @main_text = "STEP1. まずは達成したい目標を中心のマスに入力しましょう！"
    @center_text = "達成したい目標"
    @around_text = "必要な要素"
  end

  def text_step2
    @main_text = "STEP2. 目標を達成するために必要な要素を入力していきましょう！"
    @center_text = "達成したい目標"
    @around_text = "必要な要素"
    @mandala_text = @mandala.target
  end

  def text_step3
    @main_text = "STEP3. 各要素を選択し、必要な行動を入力していきましょう！"
    @center_text = "達成したい目標"
    @around_text = "必要な要素"
    @mandala_text = @mandala.target
    @element_text1 = Element.find_by(mandala_id: @mandala.id, number: 1).element
    @element_text2 = Element.find_by(mandala_id: @mandala.id, number: 2).element
    @element_text3 = Element.find_by(mandala_id: @mandala.id, number: 3).element
    @element_text4 = Element.find_by(mandala_id: @mandala.id, number: 4).element
    @element_text5 = Element.find_by(mandala_id: @mandala.id, number: 5).element
    @element_text6 = Element.find_by(mandala_id: @mandala.id, number: 6).element
    @element_text7 = Element.find_by(mandala_id: @mandala.id, number: 7).element
    @element_text8 = Element.find_by(mandala_id: @mandala.id, number: 8).element
  end

#---------------- Mandalaチャート作成ページ viewの分岐用 ----------------#

#---------------- Mandalaチャートcreateアクション用 ----------------#

  def create_step1
    mandala = current_user.mandalas.build(mandala_params)
    if mandala.save
      redirect_to new_mandala_path(step: 2)
    else
      redirect_to new_mandala_path
    end
  end

  def create_step2
    mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
    if mandala.update(mandala_params)
      redirect_to new_mandala_path(step: 3)
    else
      redirect_to new_mandala_path(step:2)
    end
  end

#---------------- Mandalaチャートcreateアクション用 ----------------#

#-------------------- 以下ストロングパラメータの定義 --------------------#

  private

  def mandala_params
    params.require(:mandala).permit(:user_id,:target, :achieved,
                    elements_attributes: [:mandala_id, :element, :number, :_destroy])
  end

  def regist_params  # ユーザー認証失敗時のパラメーターチェック
    params.permit(:regist)
  end

  def log_in_params  # ユーザー認証失敗時のパラメーターチェック
    params.permit(:log_in)
  end

  def step_params  # マンダラチャート作成STEPのパラメーターチェック
    params.permit(:step)
  end

end
