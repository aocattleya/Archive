class SignupsController < ApplicationController
  before_action :save_to_session, only: :sms_confirmation
  before_action :save_to_session2, only: :address

  def new
    session.clear
  end

  def registration
    @user = User.new
  end

  def sns_registration
    @user = User.new
  end

  def sms_confirmation
    @user = User.new
  end

  def address
    @address = Address.new
    @user = User.new unless user_signed_in?
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
      @address = Address.new(address_params.merge(user_id: @user.id))
    elsif user_signed_in?
      @address = Address.new(address_params.merge(user_id: current_user.id))
    else
      redirect_to root_path
    end
      if @address.save
        redirect_to new_card_path
      else
        session[:flag2] = @address.errors.messages.first
        session[:errorpostal_code] = @address.errors.messages[:postal_code].first
        session[:errorprefecture] = @address.errors.messages[:prefecture].first
        session[:errorcity] = @address.errors.messages[:city].first
        session[:errorstreet] = @address.errors.messages[:street].first
        session[:errorbuilding] = @address.errors.messages[:building].first
        session[:id] = @user.id
        sign_in User.find(session[:id]) unless user_signed_in?
        redirect_to address_signups_path
      end
    end

  def complete
    sign_in User.find(session[:id]) unless user_signed_in?
  end

end

def save_to_session
  unless session[:flag]
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
      uid: session[:uid],
      phonenumber: "1234567890"
    )
    if @user.invalid?
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

      session[:errorname] = @user.errors.messages[:nickname].first
      session[:errormail] = @user.errors.messages[:email].first
      session[:errorpassword] = @user.errors.messages[:password].first
      session[:errorfirstname] = @user.errors.messages[:first_name].first
      session[:errorlastname] = @user.errors.messages[:last_name].first
      session[:errorfirstname_kana] = @user.errors.messages[:first_name_kana].first
      session[:errorlastname_kana] = @user.errors.messages[:last_name_kana].first
      if session[:uid] == nil
      redirect_to registration_signups_path
      else
        redirect_to new_signup_path
      end
    end
  end
end

def save_to_session2
  unless session[:flag2]
    session[:phonenumber] = user_params[:phonenumber]
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
      uid: session[:uid],
      phonenumber: session[:phonenumber]
    )
    if @user.invalid?
      session[:errorphonenumber] = @user.errors.messages[:phonenumber].first
      session[:flag] = @user.errors.messages[:phonenumber].first
      if session[:uid] == nil
      redirect_to sms_confirmation_signups_path
      else
        redirect_to new_signup_path
      end
    end
  end
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
