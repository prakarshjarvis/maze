class PageController < ApplicationController
  def index
    @users = User.all
    @newUser = User.new
    if User.find(current_user.id)
      @user = current_user
    else 
      redirect_to new_user_session_path, notice: 'You are not logged in.'
    end
  end

  def deactivate
    @user = User.find(params[:user_id])
    @user.remove_role(:active)
    @user.add_role(:inactive)
    redirect_to page_index_path
  end

  def activate
    @user = User.find(params[:user_id])
    @user.remove_role(:inactive)
    @user.add_role(:active)
    redirect_to page_index_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to page_index_path, notice: "User succesfully created!"
    else
      redirect_to page_index_path, alert: "User cannot be created!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname)
  end

end
