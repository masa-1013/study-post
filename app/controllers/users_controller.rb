class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def index
    user = User.find_by(name: params[:name].to_s)
    redirect_to root_url unless user
    if (params[:followers] == "true")
      @user = user.followers
    else
      @user = user.followed_users
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user == current_user || @user&.public
      @user_studies = @user.studies
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = EasySettings.user_create_success
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = EasySettings.user_update
      redirect_to user_url
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :public, :image)
  end
end
