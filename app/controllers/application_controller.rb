class ApplicationController < ActionController::Base

before_action :configure_permitted_parameters, if: :devise_controller?

	include ApplicationHelper

	protected

	#許可するパラメータを追加
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
		devise_parameter_sanitizer.permit(:account_update, keys: [:username])
	end

end
