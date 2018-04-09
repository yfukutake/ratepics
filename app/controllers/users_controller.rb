class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :evaluations]
  
  def show
    @user = User.find(params[:id])
    @picture= current_user.pictures.build
    @pictures = @user.pictures.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome New User!'
      redirect_to @user
    else
      flash.now[:danger] = 'Something Gone Wrong'
      render :new
    end
  end
  
  def evaluations
    @user = current_user
    @picture= current_user.pictures.build
    @pictures = @user.scores.order('created_at DESC').page(params[:page])
    counts(@user)
    render :show 
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
