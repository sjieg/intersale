class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :set_current_attributes
  before_action :set_locale

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :show_401 # unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound, with: :show_401 # unless Rails.env.development?

  def set_current_attributes
    Current.user = current_user
    Current.locale = current_user&.locale || cookies[:locale]
  end

  def show_401
    flash.now[:error] = "You are not authorized to perform this action."
    render "errors/unauthorized"
  end

  protected

  def set_locale
    I18n.locale = Current.locale || extract_locale_from_accept_language_header
  end

  private

  def extract_locale_from_accept_language_header
    locale_key = request.env["HTTP_ACCEPT_LANGUAGE"].scan(/^[a-z]{2}/).first
    I18n.locale_available?(locale_key) ? locale_key : I18n.default_locale
  end

  def auth_token
    params.permit(:auth_token)[:auth_token]
  end
end
