class ApplicationController < ActionController::Base
# Add security token to all generated form by rails and ajax request
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # devise has already below method that is called 'user_authenticated?',
  # so it might not be necessary.
  # def authenticate_user
  #   if !user_signed_in?
  #     flash[:alert] = "Please login."
  #     redirect_to new_user_session_path
  #   end
  # end
  #
  # def forbid_login_user
  #   if user_signed_in?
  #     flash[:alert] = "You are already logged in."
  #     redirect_to posts_path
  #   end
  # end

  # def set_locale
  #   I18n.locale = params[:locale]
  # end

  # def self.default_url_options(options={})
  #   options.merge({ :locale => I18n.locale })
  # end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :date_of_birth, :address, :blog, :image_name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
  #   devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
  #   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  # end

end
