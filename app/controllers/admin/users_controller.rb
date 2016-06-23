class Admin::UsersController < ApplicationController

  before_filter :restrict_access, :admin_privileges

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    redirect_to admin_users_path
  end
end
