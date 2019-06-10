# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

skip_before_action :verify_authenticity_token, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
      def create
        # if request.xhr? #XMLHttpRequest(ajax通信)か判定
          opts = auth_options # opts = {:scope=>:user, :recall=>"users/sessions#xhr_failure"}
          opts[:recall] = "#{controller_path}#xhr_failure"
          self.resource = warden.authenticate!(opts)
          unless sign_in(resource_name, resource)

          end
          # xhr_success
          redirect_to root_path
        # else
          # @error = "ログイン失敗"
          # render :template => "mandalas/top"
        # end
      end

      def xhr_success
        render json: { result: true }
      end

      def xhr_failure
          @error = "ログイン失敗"
          render "mandalas/top"
        # render json: { result: false, errors: ["Login failed."] }
      end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
