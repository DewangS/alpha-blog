class UsersController < ApplicationController
def new
  @user = User.new
end

def create
  @user = User.new(user_params)
  if @user.save
    flash[:success] = "Welcome #{@user.username} to the Alpha-Blog. Thanks for signing up."
    redirect_to articles_path
  else
    render 'new'
  end
end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    flash[:success] = "Your account was successfuly updated."
    redirect_to articles_path
  else
    #@article.errors.full_messages.each do |msg|
    #  flash[:danger] = @article.errors.full_messages
    #end 
    #@article.errors.clear
    render 'edit'
  end
end

private
def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end