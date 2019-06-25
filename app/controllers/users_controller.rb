class UsersController < ApplicationController

  def show
    if @mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
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
  end

  def graph
    @mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
    gon.element = @mandala.elements.pluck(:target)
    gon.scores_this_week = score_this_week(@mandala)
    gon.scores_last_week = score_last_week(@mandala)
    gon.task_comp_this_week = task_comp_this_week(@mandala)
    gon.task_comp_last_week = task_comp_last_week(@mandala)
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      render 'edit'
    end
  end


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


  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
