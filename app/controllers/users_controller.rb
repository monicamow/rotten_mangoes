class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
   
    if @user.save
      unless User.find(session[:user_id]).admin
        session[:user_id] = @user.id # auto log in
      end
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!" # show movie listing as home page
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
