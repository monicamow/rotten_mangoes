class SessionsController < ApplicationController
  def new
  end

  def create
    # find the user based on the email in the "email" input field
    user = User.find_by(email: params[:email]) #

    # make sure that user exists and can be authenticated 
    # by the password in the "password" input field
    if user && user.authenticate(params[:password])
      # set the :user_id key in the sessions hash to the user's id
      session[:user_id] = user.id 
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
    else
      flash.now[:alert] = "Log in failed..."
      render :new # show sign up page if user doesn't exist
    end
  end

  def destroy
    # clear session
    session[:user_id] = nil
    # redirect
    redirect_to welcome_index_path, notice: "BAH FELICIA!"
  end
end
