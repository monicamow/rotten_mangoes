class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  # easy, application-wide way to check if a user is logged in

  def restrict_access
    unless current_user
      flash[:alert] = "You must be logged in."
      redirect_to new_session_path
    end
  end

  def admin_privileges
    unless current_user.admin
      flash[:alert] = "You do not have these privileges."
      redirect_to welcome_index_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
