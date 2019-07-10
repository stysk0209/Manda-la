module ApplicationHelper


	# ログインチェック & マンダラチャートの作成が完了していなかったら、作成画面へ遷移
	def mandala_complete?
		unless user_signed_in?
			redirect_to root_path and return
		end
		if mandala = Mandala.find_by(user_id: current_user.id, achieved: false)
			unless elements = mandala.elements
				redirect_to new_mandala_path(step: 2)
			end
			elements.each do |element|
				(element.activities.present?) ? (true) : (redirect_to new_mandala_path(step: 3) and return)
			end
		end
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
