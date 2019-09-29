class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    @user = User.find_by(name: session_params[:name])

    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      flash[:success] = EasySettings.login_success
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    reset_session
    flash[:success] = EasySettings.logout_success
    redirect_to login_url
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
