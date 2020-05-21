class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def new
   @work = Work.new
  end

  def show
    if @work.nil?
      head :not_found
      return
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save 
      flash[:success] = "Successfully created #{@work.category} #{@work.id} "
      redirect_to work_path(@work.id)
      return
    else 
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      render :new, status: :bad_request
      return
    end
    
  end

  def edit
    if @work.nil?
      redirect_to works_path 
      return
    end
  end

  def update
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id} "
      redirect_to work_path 
      return
    else 
      flash.now[:error] = "A problem occurred: Could not edit #{@work.category}"
      render :edit
      return
    end
  end

  def destroy
    if @work.nil?
      flash.now[:error] = "A problem occurred: Could not delete"
      redirect_to work_path
      return
    end

    @work.destroy
    flash[:success] = "Successfully deleted #{@work.category} #{@work.id} "
    redirect_to works_path 
    return
  end

  private

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description )
  end

  def find_work
    @work = Work.find_by_id(params[:id])
  end
end
