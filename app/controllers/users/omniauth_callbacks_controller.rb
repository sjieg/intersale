# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_forgery_protection only: :developer
  skip_after_action :verify_authorized

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # def google_oauth2
  #   user = User.from_omniauth(auth)
  #   if user.present?
  #     sign_out_all_scopes
  #     flash[:success] = t "devise.omniauth_callbacks.success", kind: "Google"
  #     sign_in_and_redirect user, event: :authentication
  #   else
  #     flash[:alert] =
  #       t "devise.omniauth_callbacks.failure", kind: "Google", reason: "#{auth.info.email} is not authorized."
  #     redirect_to new_user_session_path
  #   end
  # end

  def developer
    raise "Developer login not allowed in production" if Rails.env.production?
    data = request.env["omniauth.auth"].info
    data["name"] = "Dev Account"
    if (@user = User.find_by(email: data["email"]))
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] =
        t "devise.omniauth_callbacks.failure", kind: "Developer", reason: "#{auth.info.email} does not exist."
      redirect_to new_user_session_path
    end
  end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  private

  def auth
    @auth ||= request.env["omniauth.auth"]
  end
end
