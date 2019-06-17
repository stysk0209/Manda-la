class UsersController < ApplicationController

  def index
  end

  def show
    gon.step = 3 #jQuery分岐用
    if params[:element_select]
      @around_text = "必要な行動"
      @center_text = "必要な要素"
      mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
      @mandala_center = Element.find_by(Mandala_id: mandala.id, number: params[:element_select])
      text_element #viewに反映させるテキスト情報
    else
      @around_text = "必要な要素"
      @center_text = "達成したい目標"
      @mandala_center = Mandala.find_by(user_id: current_user.id, achieved: false)
      text_mandala #viewに反映させるテキスト情報
    end
  end

  def create
  end

  def edit
  end

  def update
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

end
