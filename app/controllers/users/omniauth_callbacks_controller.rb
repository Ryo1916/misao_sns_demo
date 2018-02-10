# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  before_action :user_signed_in?

  def facebook
    callback_from :facebook
  end

  def twitter
    callback_from :twitter
  end

  def google_oauth2
    callback_from :google_oauth2
  end

  # You should also create an action method in this controller like this:
  # def twitter
  #   @user = User.from_omniauth(request.env["omniauth.auth"].except("extra"))
  #
  #     if @user.persisted?
  #        sign_in_and_redirect @user
  #     else
  #       session["devise.user_attributes"] = @user.attributes
  #       redirect_to new_user_registration_url
  #     end
  #   end
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  private

  def callback_from(provider)
    provider = provider.to_s
    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth.except('extra')

    # @user = User.find_or_create_from_oauth(auth)
    @user = User.find_by(provider: auth.provider, uid: auth.uid)

    if @user
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      session[:user_id] = @user.id
      sign_in_and_redirect @user, event: :authentication
    else
      @user = User.create_from_omniauth(auth)
      flash[:notice] = I18n.t('devise.confirmations.send_instructions')
      redirect_to new_user_session_path
      # session["devise.#{provider}_data"] = request.env['omniauth.auth']
      # redirect_to new_user_registration_url
    end
  end

end
