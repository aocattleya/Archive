class SignupsController < ApplicationController
  # before_action :save_to_session, only: :sms_confirmation

  def new
  end

  def registration
    @user = User.new
  end

  def sns_registration
    @user = User.new
  end

  def sms_confirmation
    if session[:uid] == nil
      session[:password] = user_params[:password]
    end
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthday_year] = user_params[:"birthday_year(1i)"].to_i
    session[:birthday_month] = user_params[:"birthday_month(2i)"].to_i
    session[:birthday_day] = user_params[:"birthday_day(1i)"].to_i
    @user = User.new
  end

  def address
    @address = Address.new
    @user = User.new
    session[:phonenumber] = user_params[:phonenumber]
  end

  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day],
      phonenumber: session[:phonenumber],
      provider: session[:provider],
      uid: session[:uid]
    )
    if @user.save
      @address = Address.new(address_params)
       if @address.save
          session[:id] = @user.id
          redirect_to new_card_path
       else
           redirect_to root_path
       end
    else
      render '/signups/registration'
    end
  end

  def complete
    sign_in User.find(session[:id]) unless user_signed_in?
  end

end

def save_to_session
  if session[:uid] == nil
    session[:password] = user_params[:password]
  end
  session[:nickname] = user_params[:nickname]
  session[:email] = user_params[:email]
  session[:last_name] = user_params[:last_name]
  session[:first_name] = user_params[:first_name]
  session[:last_name_kana] = user_params[:last_name_kana]
  session[:first_name_kana] = user_params[:first_name_kana]
  session[:birthday_year] = user_params[:birthday_year]
  session[:birthday_month] = user_params[:birthday_month]
  session[:birthday_day] = user_params[:birthday_day]

  @user = User.new(
    nickname: session[:nickname],
    email: session[:email],
    password: session[:password],
    last_name: session[:last_name],
    first_name: session[:first_name],
    last_name_kana: session[:last_name_kana],
    first_name_kana: session[:first_name_kana],
    birthday_year: session[:birthday_year],
    birthday_month: session[:birthday_month],
    birthday_day: session[:birthday_day],
    provider: session[:provider],
    uid: session[:uid]
    )
  render "signups/registration" unless @user.valid?
end


private

  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :phonenumber,
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :birthday_year,
      :birthday_month,
      :birthday_day
    )
  end

  def address_params
    params.require(:address).permit(
      :postal_code,
      :prefecture,
      :city,
      :street,
      :building
    )
  end