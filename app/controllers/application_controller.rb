class ApplicationController < ActionController::Base

  before_action :authenticate_user!, unless: :admin_url
  before_action :authenticate_admin!, if: :admin_url

  def admin_url
    request.fullpath.include?("/admin")
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

   def after_sign_in_path_for(resource)
     if admin_signed_in?
       admins_users_path
     else
       users_user_path(current_user.id)
     end
   end

  def after_sign_out_path_for(resource)
    about_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email])
  end

end
