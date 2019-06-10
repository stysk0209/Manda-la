class ApplicationController < ActionController::Base
before_action :configure_permitted_parametars, if: :devise_controller?

	protected

	def configure_permitted_parametars
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
	end

end
