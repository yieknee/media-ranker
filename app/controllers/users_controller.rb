class UsersController < ApplicationController
 
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params[:user][:username])
    if @user.nil?
      @user = User.new(username: params[:user][:username])
      if ! @user.save
          flash.now[:error] = "A problem occurred: Could not log in"
          render :login_form, status: :bad_request
          return
      end
      flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
    else
      flash[:success] = "Successfully logged in as existing user #{@user.username}"
    end
    session[:user_id] = @user.id 
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
