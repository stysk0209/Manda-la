class MandalasController < ApplicationController

  def top
      gon.registfail = regist_params[:regist]
      gon.log_in_fail = log_in_params[:log_in]
  end

  def about
  end

  def new
    if params[:step] == "2"
      new_step2
    elsif params[:step] == "3"
      new_step3
    elsif params[:element_edit]
      new_activity
    else #必要な行動を入力する画面へ
      new_step1
    end
  end

  def create
    if params[:step] == "1" #達成したい目標を保存する
      create_step1
    elsif params[:step] == "2" #目標に紐づく必要な要素を保存
      create_step2
    elsif params[:step] == "3" #チャート作成完了

    else #params[:step] == "4"  必要な行動を保存
      create_activity
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
    @mandala_center = Mandala.new
    @mandala_center.elements.build
    text_step1
  end

  def new_step2
    @step = 2 #view分岐用
    gon.step = 2 #jQuery分岐用
    @mandala_center = Mandala.find_by(user_id: current_user.id, achieved: false)
    @mandala_center.elements.build
    text_step2
  end

  def new_step3
    @step = 3 #view分岐用
    gon.step = 3 #jQuery分岐用
    @mandala_center = Mandala.find_by(user_id: current_user.id, achieved: false)
    text_step3
  end

  def new_activity
    @step = 4 #view分岐用
    gon.step = 4 #jQuery分岐用
    mandala = Mandala.find_by(user_id: current_user, achieved: false)
    @mandala_center = Element.find_by(mandala_id: mandala.id, number: params[:element_edit].to_i)
    text_step4
    @mandala_center.activities.build
  end

#-------------------- Mandalaチャートnewアクション用 --------------------#

#---------------- Mandalaチャート作成ページ text埋め込み用 ----------------#

  def text_step1
    @main_text = "STEP1. まずは達成したい目標を中心のマスに入力しましょう！"
    @center_text = "達成したい目標"
    @around_text = "必要な要素"
  end

  def text_step2
    @main_text = "STEP2. 目標を達成するために必要な要素を入力していきましょう！"
    @center_text = "達成したい目標"
    @around_text = "必要な要素"
    @element_text5 = @mandala_center.target
  end

  def text_step3
    @main_text = "STEP3. 各要素を選択し、必要な行動を入力していきましょう！"
    @center_text = "達成したい目標"
    @around_text = "必要な要素"
    @element_text1 = Element.find_by(mandala_id: @mandala_center.id, number: 1).target
    @element_text2 = Element.find_by(mandala_id: @mandala_center.id, number: 2).target
    @element_text3 = Element.find_by(mandala_id: @mandala_center.id, number: 3).target
    @element_text4 = Element.find_by(mandala_id: @mandala_center.id, number: 4).target
    @element_text5 = @mandala_center.target
    @element_text6 = Element.find_by(mandala_id: @mandala_center.id, number: 5).target
    @element_text7 = Element.find_by(mandala_id: @mandala_center.id, number: 6).target
    @element_text8 = Element.find_by(mandala_id: @mandala_center.id, number: 7).target
    @element_text9 = Element.find_by(mandala_id: @mandala_center.id, number: 8).target
  end

  def text_step4
    @main_text = "要素を実現するために必要な行動を入力していきましょう！"
    @center_text = "必要な要素"
    @around_text = "必要な行動"
    @element_text5 = @mandala_center.target
    if @mandala_center.activities.present?
      @element_text1 = Activity.find_by(element_id: @mandala_center.id, number: 1).target
      @element_text2 = Activity.find_by(element_id: @mandala_center.id, number: 2).target
      @element_text3 = Activity.find_by(element_id: @mandala_center.id, number: 3).target
      @element_text4 = Activity.find_by(element_id: @mandala_center.id, number: 4).target
      @element_text6 = Activity.find_by(element_id: @mandala_center.id, number: 5).target
      @element_text7 = Activity.find_by(element_id: @mandala_center.id, number: 6).target
      @element_text8 = Activity.find_by(element_id: @mandala_center.id, number: 7).target
      @element_text9 = Activity.find_by(element_id: @mandala_center.id, number: 8).target
    end
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

  def create_step3
    mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
    if mandala.update!(mandala_params)
      redirect_to user_path(current_user.id)
    else
      redirect_to new_mandala_path(step:3)
    end
  end

  def create_activity
    mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
    element = Element.find_by(mandala_id: mandala.id, number: params[:element][:number] )
    if element.update(element_params)
      redirect_to new_mandala_path(step: 3)
    else
      redirect_to new_mandala_path(element: params[:element][:number])
    end
  end

#---------------- Mandalaチャートcreateアクション用 ----------------#

#-------------------- 以下ストロングパラメータの定義 --------------------#

  private

  def mandala_params
    params.require(:mandala).permit(:user_id, :target, :achieved,
                    elements_attributes: [:id, :mandala_id, :target, :number, :_destroy])
  end

  def element_params
    params.require(:element).permit(:mandala_id, :target,
                    activities_attributes: [:id, :element_id, :target, :number, :_destroy])
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

  def element_edit_params  # マンダラチャート作成Elementのパラメーターチェック
    params.permit(:element_edit)
  end

end
