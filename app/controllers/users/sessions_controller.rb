# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    email =  params['user']['email']
    user = User.find_by(email: email)
    unless user
      flash.now[:error] = 'メッセージの送信に失敗しました'
      render "/mandalas/top" and return
    end
    if user.valid_password?(params['user']['password'])
      sign_in(user)
      redirect_to root_path
    else
      flash.now[:error] = 'メッセージの送信に失敗しました'
      render "/mandalas/top"
    end
  end
end
