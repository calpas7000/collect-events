class Admin::UsersController < ApplicationController
  before_action :require_user_logged_in
  before_action :admin_user

  def index
    @users = User.all
  end

  private
  
end
