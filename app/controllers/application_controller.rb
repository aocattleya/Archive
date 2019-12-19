class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,
                                                          :email,
                                                          :phonenumber,
                                                          :last_name,
                                                          :first_name,
                                                          :last_name_kana,
                                                          :first_name_kana,
                                                          :birthday_year,
                                                          :birthday_month,
                                                          :birthday_day,
                                                          :profile,
                                                          :image])
  end
end