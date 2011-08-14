class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def index
    @users = User.all
  end
  
  def signup
    @title = "Sign up"
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the sample app!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'signup'
    end
  end
end
