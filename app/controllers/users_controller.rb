class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def show
    @user_studies = current_user.studies
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = EasySettings.user_create_success
      session[:user_id] = @user.id
      redirect_to users_show_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = current_user.public ? EasySettings.user_public_true : EasySettings.user_public_false
      redirect_to users_show_url
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :public)
  end
end
