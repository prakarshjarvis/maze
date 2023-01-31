class PageController < ApplicationController
  def index
    if User.find(current_user.id)
      @user = current_user
    else 
      redirect_to new_user_session_path, notice: 'You are not logged in.'
    end
  end
end
