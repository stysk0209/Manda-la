class CustomFailure < Devise::FailureApp

  # config.autoload_paths << Rails.root.join('lib')

  def redirect_url
    root_path
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect_to root_path(log_in: false)
    end
  end

end