class VotesController < ApplicationController
  def create
    work_id = params[:work_id]
    
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      user_id = user.id
      vote = Vote.new(work_id: work_id, user_id: user_id)
      if vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
        return
      else
        flash[:error] = "A problem occurred: Could not upvote"
        @validation_error = vote.errors
        redirect_back(fallback_location: root_path)
        return
      end
    else
      flash[:warning] = "A problem occured: You must be logged in to do that"
        redirect_back(fallback_location: root_path)
      return
    end
  end

  private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
end
