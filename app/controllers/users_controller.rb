class UsersController < ApplicationController

  def new
  	@title = 'Sign Up'
    @user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the sample app - #{@user.name}"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
