class Point < ApplicationRecord

	belongs_to :user
	belongs_to :element


	#先週登録されたPointを取得
	scope :last_week, -> { where(created_at: Time.now.prev_week.beginning_of_week(:sunday)..Time.now.prev_week.end_of_week(:sunday)) }
	#今週登録されたPointを取得
	scope :this_week, -> { where(created_at: Time.now.beginning_of_week(:sunday)..Time.now.end_of_week(:sunday)) }
	#element.id(KEY),point(value)のハッシュ形式で取得
	scope :element_points, -> { group(:element_id).sum(:point) }

	scope :on_last_week, -> { last_week.element_points }

	scope :on_this_week, -> { this_week.element_points }

end
