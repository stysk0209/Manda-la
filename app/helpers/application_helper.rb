module ApplicationHelper

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
