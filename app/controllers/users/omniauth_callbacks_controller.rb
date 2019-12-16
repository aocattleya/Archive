class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google
    callback_for(:google)
  end

  def facebook
    callback_for(:facebook)
  end

  def callback_for(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      session[:uid] = session["devise.#{provider}_data"][:uid]
      session[:provider] = session["devise.#{provider}_data"][:provider]
      session[:email] = session["devise.#{provider}_data"][:info][:email]
      session[:nickname] = session["devise.#{provider}_data"][:info][:name]
      session[:password] = Devise.friendly_token[7, 20]

      render "signups/sns_registration"
    end
  end

  def failure
    redirect_to root_path
  end
end