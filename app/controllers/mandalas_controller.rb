class MandalasController < ApplicationController

#mandala_complete?メソッドは、ほかのコントローラーと共通の処理のため、Aplication_Helperに記述
before_action :sign_in_auth, only:[:new]
before_action :mandala_complete?, only:[:edit]

  #GET / (root_path)
  def top
      gon.registfail = regist_params[:regist] #会員登録認証失敗時のパラメータ
      gon.log_in_fail = log_in_params[:log_in] #ログイン失敗時のパラメータ
  end

  #GET /mandalas/new (new_mandala_path)
  #params[:step]のvalueで、処理を分岐します。
  #params[:element_edit] trueで、必要な要素を中心とした、行動入力画面へ
  def new
    @main_title = "マンダラチャートを作成しよう！"
    if params[:step] == "2"
      new_step2
    elsif params[:step] == "3"
      new_step3
    elsif params[:element_edit]
      new_activity
    else
      new_step1
    end
  end

  #POST /mandalas (mandalas_path)
  #params[:step]のvalueで、処理を分岐します。
  def create
    if params[:step] == "1" #達成したい目標を保存する
      create_step1
    elsif params[:step] == "2" #目標に紐づく必要な要素を保存
      create_step2
    elsif params[:step] == "3" #チャート作成完了
      create_step3
    else #params[:step] == "4"  必要な行動を保存
      create_activity
    end
  end

  #GET /mandala/:id/edit (edit_mandala_path)
  def edit
    @mandala = Mandala.find_by(user_id: current_user, achieved: false)
    @main_title = "マンダラチャート編集"
    gon.form_edit = true
    if params[:element_edit] #必要な行動編集画面へ
      gon.step ="el_edit"
      @step = "el_edit"
      @mandala_center = Element.find_by(mandala_id: @mandala.id, number: params[:element_edit].to_i)
      @mandala_center.activities.build
      square_text2
      element_activity_text
    else
      @step = "edit"
      gon.step = "edit"
      @mandala_center = Mandala.find_by(user_id: current_user.id, achieved: false)
      @mandala_center.elements.build
      square_text1
      mandala_element_text
    end
  end

  #POST /mandala/:id (mandala_path)
  def update
    if params[:step] == "el_edit" #必要な行動入力画面からPOSTされてきたら
      create_activity
    else
      create_step3
    end
  end

  #DELETE /mandala/:id (mandala_path)
  def destroy
    mandala = Mandala.find(params[:id])
    mandala.destroy
    redirect_to user_path(current_user.id)
  end




  private

#-------------------- Mandalaチャートnewアクション用 --------------------#

  def new_step1
    @step = 1 #view分岐用
    gon.step = 1 #jQuery分岐用
    @mandala_center = Mandala.new
    @mandala_center.elements.build
    @main_text = "STEP1. まずは達成したい目標を中心のマスに入力しましょう！"
    @center_text = "達成したい目標"
  end

  def new_step2
    @step = 2 #view分岐用
    gon.step = 2 #jQuery分岐用
    @mandala_center = Mandala.find_by(user_id: current_user.id, achieved: false)
    @mandala_center.elements.build
    @main_text = "STEP2. 目標を達成するために必要な要素を入力していきましょう！"
    square_text1
    @element_text5 = @mandala_center.target
  end

  def new_step3
    @step = 3 #view分岐用
    gon.step = 3 #jQuery分岐用
    @mandala_center = Mandala.find_by(user_id: current_user.id, achieved: false)
    @main_text = "STEP3. 各要素を選択し、必要な行動を入力していきましょう！"
    square_text1
    mandala_element_text
  end

  def new_activity
    @step = 4 #view分岐用
    gon.step = 4 #jQuery分岐用
    mandala = Mandala.find_by(user_id: current_user, achieved: false)
    @mandala_center = Element.find_by(mandala_id: mandala.id, number: params[:element_edit].to_i)
    @main_text = "要素を実現するために必要な行動を入力していきましょう！"
    square_text2
    if @mandala_center.activities.present? #すでに必要な行動が入力済みなら、テキスト情報をviewへ渡す
      element_activity_text
    end
    @mandala_center.activities.build
    @element_text5 = @mandala_center.target
  end

#-------------------- Mandalaチャートnewアクション用 --------------------#

#---------------- Mandalaチャート作成ページ text埋め込み用 ----------------#

  def square_text1
    @center_text = "達成したい目標"
    @around_text = "必要な要素"
  end

  def square_text2
    @center_text = "必要な要素"
    @around_text = "必要な行動"
  end

  def mandala_element_text #viewで表示するテキスト
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

  def element_activity_text #viewで表示するテキスト
    @element_text1 = Activity.find_by(element_id: @mandala_center.id, number: 1).target
    @element_text2 = Activity.find_by(element_id: @mandala_center.id, number: 2).target
    @element_text3 = Activity.find_by(element_id: @mandala_center.id, number: 3).target
    @element_text4 = Activity.find_by(element_id: @mandala_center.id, number: 4).target
    @element_text5 = @mandala_center.target
    @element_text6 = Activity.find_by(element_id: @mandala_center.id, number: 5).target
    @element_text7 = Activity.find_by(element_id: @mandala_center.id, number: 6).target
    @element_text8 = Activity.find_by(element_id: @mandala_center.id, number: 7).target
    @element_text9 = Activity.find_by(element_id: @mandala_center.id, number: 8).target
  end

#---------------- Mandalaチャート作成ページ viewの分岐用 ----------------#

#---------------- Mandalaチャートcreateアクション用 ----------------#

  def create_step1
    mandala = current_user.mandalas.build(mandala_params)
    if mandala.save
      redirect_to new_mandala_path(step: 2)
    else
      redirect_to new_mandala_path
      flash[:errors] = mandala.errors.full_messages
    end
  end

  def create_step2
    mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
    if mandala.update(mandala_params)
      redirect_to new_mandala_path(step: 3)
    else
      redirect_to new_mandala_path(step:2, mandala: mandala_params[:mandala])
      flash[:errors] = mandala.errors.full_messages
    end
  end

  def create_step3
    mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
    unless activity_complete_auth(mandala) #必要な行動が入力されていないものがあるか判定
      flash[:errors] = ["必要な行動が入力されていない要素があります。"]
      redirect_to new_mandala_path(step:3)
    else
      if mandala.update(mandala_params) #例外処理
        redirect_to user_path(current_user.id)
      else
        if request.path.include?(mandala_path(mandala.id))
          redirect_to edit_mandala_path
        else
          redirect_to new_mandala_path(step:3)
          flash[:errors] = mandala.errors.full_messages
        end
      end
    end
  end


  def create_activity
    mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
    element = Element.find_by(mandala_id: mandala.id, number: params[:element][:number].to_i )
    if element.update(element_params)
      if request.path.include?(mandala_path(current_user.id)) #リクエストURLをチェック(mandala/:id/editから来たらtrue)
        redirect_to edit_mandala_path(mandala.id)
      else
        redirect_to new_mandala_path(step: 3)
      end
    else #update失敗時
      if request.path.include?(mandala_path(current_user.id)) #リクエストURLをチェック(mandala/:id/editから来たらtrue)
        redirect_to edit_mandala_path(element_edit: params[:element][:number].to_i)
        flash[:errors] = element.errors.full_messages
      else
        redirect_to new_mandala_path(element_edit: params[:element][:number].to_i)
        flash[:errors] = element.errors.full_messages
      end
    end
  end

#---------------- 各認証チェックアクション ----------------#

  #必要な行動をすべて入力済みかチェック(STEP3用)
  def activity_complete_auth(mandala)
    mandala.elements.each do |element|
      unless element.activities.present?
        return false
      end
    end
    return true
  end

  #ログイン認証用
  def sign_in_auth
    unless user_signed_in?
      redirect_to root_path
    end
  end
#-------------------- 以下ストロングパラメータの定義 --------------------#

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
