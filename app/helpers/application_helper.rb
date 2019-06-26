module ApplicationHelper


	def score_this_week(mandala)
		elements = mandala.elements.pluck(:id) # idを配列形式に
		scores = {} #ハッシュ形式で保存する宣言
		elements.each { |element| scores[element] = 0 } # { id => 0, id => 0,...}のハッシュ形式に
		points_this_week = Point.where(user_id: current_user.id, created_at: Time.now.beginning_of_week(:sunday)..Time.now.end_of_week(:sunday))
								.group(:element_id).sum(:point)
		points_this_week.each{ |key,value| scores[key] = value}

		return scores.values
	end

	def score_last_week(mandala)
		elements = mandala.elements.pluck(:id) # idを配列形式に
		scores = {} #ハッシュ形式で保存する宣言
		elements.each { |element| scores[element] = 0 } # { id => 0, id => 0,...}のハッシュ形式に
		points_last_week = Point.where(user_id: current_user.id, created_at: Time.now.prev_week.beginning_of_week(:sunday)..Time.now.prev_week.end_of_week(:sunday))
								.group(:element_id).sum(:point)
		points_last_week.each{ |key,value| scores[key] = value}

		return scores.values
	end

	def achieved_this_week(mandala)
		by_weekday = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0} #曜日別タスク完了数を初期化
		points_this_week = Point.where(user_id: current_user.id, created_at: Time.now.beginning_of_week(:sunday)..Time.now.end_of_week(:sunday)).group(:element_id)
		this_week = Point.where(user_id: current_user.id, created_at: Time.now.beginning_of_week(:sunday)..Time.now.end_of_week(:sunday))
		by_date = this_week.group_by{|u| u.created_at.wday }
		by_date.each{ |key, value| by_weekday[key] = value.count }

		return by_weekday.values
	end

	def achieved_last_week(mandala)
		by_weekday = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0} #曜日別タスク完了数を初期化
		points_this_week = Point.where(user_id: current_user.id, created_at: Time.now.beginning_of_week(:sunday)..Time.now.end_of_week(:sunday)).group(:element_id)
		this_week = Point.where(user_id: current_user.id, created_at: Time.now.prev_week.beginning_of_week(:sunday)..Time.now.prev_week.end_of_week(:sunday))
		by_date = this_week.group_by{|u| u.created_at.wday }
		by_date.each{ |key, value| by_weekday[key] = value.count }

		return by_weekday.values
	end

	def score_comp(mandala)
		elements = mandala.elements.pluck(:id) # idを配列形式に
		scores = {} #ハッシュ形式で保存する宣言
		elements.each { |element| scores[element] = 0 } # { id => 0, id => 0,...}のハッシュ形式に
		points_comp = Point.where(user_id: current_user.id).group(:element_id).sum(:point)
		points_comp.each{ |key,value| scores[key] = value}

		return scores.values
	end

	def achieved_comp
		hash = {}
		6.times.map do |i|
			hash.store((Date.today - i.months).mon, Point.where(user_id: current_user.id, created_at: (Date.today - i.months).all_month).count )
		end
		result = hash.map do |key, value|
					hash.values.inject(:+)
					hash.delete(key)
		end

		return result.sort!
	end



# No Method Error undefined local variable or method `resource'の対応で記述
	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

end
