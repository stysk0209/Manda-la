class UsersController < ApplicationController

before_action :mandala_complete?, only:[:show, :graph ]

  #GET /users/:id (user_path)
  def show
    if @mandala = Mandala.find_by(user_id: current_user.id, achieved: false) #マンダラチャート作成済みかチェック
      @task_new = Task.new
      @tasks = Task.where(user_id: current_user.id, done: false)
      gon.step = 3 #jQuery分岐用
      if params[:overlooking]
        gon.step = "element_overlooking"
        @squares_overlooking = true
        @mandala_center = @mandala
      else
        if params[:element_select]
          gon.step = "element_select"
          @element_select = true
          @around_text = "必要な行動"
          @center_text = "必要な要素"
          @mandala_center = Element.find_by(Mandala_id: @mandala.id, number: params[:element_select])
          text_element #viewに反映させるテキスト情報
        else
          @around_text = "必要な要素"
          @center_text = "達成したい目標"
          @mandala_center = Mandala.find_by(user_id: current_user.id, achieved: false)
          text_mandala #viewに反映させるテキスト情報
        end
      end
    end
    if params[:ajax]
      render partial: 'users/mypage_mandalachart', locals: { center_text: @center_text, around_text: @around_text, element_text1: @element_text1,
                                                              element_text2: @element_text2,element_text3: @element_text3, element_text4: @element_text4,
                                                              element_text5: @element_text5, element_text6: @element_text6, element_text7: @element_text7,
                                                              element_text8: @element_text8, element_text9: @element_text9, element_select: @element_select }, layout: false
    end
  end

  #GET /users/:id/graph (user_graph_path)
  def graph
    @mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
    gon.element = @mandala.elements.pluck(:target) #グラフのラベル用
    if params[:total] #総計表示
      gon.score_all = score_comp(@mandala)
      gon.achieved_comp = achieved_comp(@mandala) #月ごとのタスク実行数
    else
      @weekly = true
      gon.scores_this_week = score_this_week(@mandala) #今週のデータ
      gon.scores_last_week = score_last_week(@mandala) #先週のデータ
      gon.task_comp_this_week = achieved_this_week(@mandala) #今週のデータ
      gon.task_comp_last_week = achieved_last_week(@mandala) #先週のデータ
    end
  end

  #GET /users/:id/edit (edit_user_path)
  def edit
    @user = current_user
  end

  #PACTH /users/:id (user_path)
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      render 'edit'
    end
  end





  private

#-------------------- graph計算メソッド --------------------#

  def score_this_week(mandala)
    elements = mandala.elements.pluck(:id) # idを配列形式に
    scores = {} #ハッシュ形式で保存する宣言
    elements.each { |element| scores[element] = 0 } # { id => 0, id => 0,...}のハッシュ形式に
    points = Point.where(element_id: elements)
    this_week = points.on_this_week
    this_week.each{ |key,value| scores[key] = value}

    return scores.values
  end

  def score_last_week(mandala)
    elements = mandala.elements.pluck(:id) # idを配列形式に
    scores = {} #ハッシュ形式で保存する宣言
    elements.each { |element| scores[element] = 0 } # { id => 0, id => 0,...}のハッシュ形式に
    points = Point.where(element_id: elements)
    last_week = points.on_last_week
    last_week.each{ |key,value| scores[key] = value}

    return scores.values
  end

  def achieved_this_week(mandala)
    by_weekday = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0} #曜日別タスク完了数を初期化
    elements = mandala.elements.pluck(:id)
    points = Point.where(element_id: elements)
    this_week = points.this_week
    by_date = this_week.group_by{|w| w.created_at.wday }
    by_date.each{ |key, value| by_weekday[key] = value.count }

    return by_weekday.values
  end

  def achieved_last_week(mandala)
    by_weekday = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0} #曜日別タスク完了数を初期化
    elements = mandala.elements.pluck(:id)
    points = Point.where(element_id: elements)
    points_last_week = points.last_week
    by_date = points_last_week.group_by{|u| u.created_at.wday }
    by_date.each{ |key, value| by_weekday[key] = value.count }

    return by_weekday.values
  end

  def score_comp(mandala)
    elements = mandala.elements.pluck(:id) # idを配列形式に
    points = Point.where(element_id: elements)
    scores = {} #ハッシュ形式で保存する宣言
    elements.each { |element| scores[element] = 0 } # { id => 0, id => 0,...}のハッシュ形式に
    points_comp = points.element_points
    points_comp.each{ |key,value| scores[key] = value}

    return scores.values
  end

  def achieved_comp(mandala)
    elements = mandala.elements.pluck(:id) # idを配列形式に
    points = Point.where(element_id: elements)
    hash = {}
    6.times.map do |i|
      hash.store((Date.today - i.months).mon, points.where(created_at: (Date.today - i.months).all_month) )
    end
    point_sum = hash.map do |key, value|
          value.count
    end
    result = point_sum.map.with_index do | point,i |
      point_sum[i..5].sum
    end

    return result.sort!
  end



#-------------------- viewに反映するテキスト処理 --------------------#

  def text_mandala
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

  def text_element
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

#-------------------- 以下ストロングパラメータの記述 --------------------#

  def sign_in_auth
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
