class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.new(username: username)
    @user = User.find_by(username: username)
    if user.valid?
      if @user
        session[:user_id] = @user.id
        flash[:success] = "Successfully logged in as returning user #{username}"
      else
        @user = User.create(username: username)
        session[:user_id] = @user.id
        flash[:success] = "Successfully logged in as new user #{username}"
      end
    else
      flash.now[:error] = "A problem occured: Could not log in"
      render :login_form
      return
    end
  
    redirect_to root_path
    return
  end

   
  # def login
  #   user = User.find_by(params[:user][:username])
  #   if user.nil?
  #     user = User.new(name: params[:user][:username])
  #     if ! user.save
  #       flash.now[:error] = "Unable to login"
  #       render :login_form
  #       return
  #     end
  #     flash[:welcome] = "Welcome #{user.username}"
  #   else
  #     # Existing User
  #     flash[:welcome] = "Welcome back #{user.username}"
  #   end
  #   session[:user_id] = user.id 
  #   redirect_to root_path
  # end

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
