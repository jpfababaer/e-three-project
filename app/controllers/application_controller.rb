class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:landing]
  before_action :additional_parameters, if: :devise_controller?

  include Pundit

  protected

  def additional_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :role])
  end
end
