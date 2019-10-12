class StudiesController < ApplicationController
  before_action :set_study, only: [:edit, :update, :destroy]

  def index
    @studies = Study.select_public_studies
  end

  def show
    @study = Study.find(params[:id])
    @comments = @study.select_comments_and_user_name
    @comment = Comment.new
    if @study.can_show_study(current_user)
      @study
    else
      redirect_to current_user
    end
  end

  def new
    @study = Study.new
  end

  def create
    @study = current_user.studies.new(study_params)
    if @study.save
      flash[:success] = EasySettings.study_create_success
      redirect_to @study
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @study.update(study_params)
      flash[:success] = EasySettings.study_update_success
      redirect_to @study
    else
      render "edit"
    end
  end

  def destroy
    @study.destroy
    flash[:danger] = EasySettings.study_delete_success
    binding.pry
    redirect_to studies_url
  end

  private 

  def study_params
    params.require(:study).permit(:tag, :content, :time, :date)
  end

  def set_study
    @study = current_user.studies.find(params[:id])
  end
end
