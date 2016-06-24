class UsersController < ApplicationController

  def show
    @user = User.find(params[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
   
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      if current_user.nil?
        session[:user_id] = @user.id # auto log in
        redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!" # show movie listing as home page
      end
    else
      render 'new' # save the already-typed info
    end    
  end

  private
    def user_params
      params.require(:user).permit(:email, :firstname, 
      :lastname, :password, :password_confirmation, :admin)
    end
end
