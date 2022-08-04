class ApplicationController < ActionController::Base

  #before_action :authenticate_customer!, unless: :admin_url
  #before_action :authenticate_admin!, if: :admin_url

  #def admin_url
   # request.fullpath.include?("/admin")
  #end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    admin_session_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
