class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.csv do
        filename = ['Users', Date.today.to_s].join(' ')
        send_data User.to_csv(@users, params[:count]), filename:, content_type: 'text/csv'
      end
      format.xlsx {
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename=users.xlsx"
      }
    end
  end
end