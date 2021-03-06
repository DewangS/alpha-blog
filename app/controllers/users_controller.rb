class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
def index
    @users = User.order("username").paginate(page: params[:page], per_page: 5)
end

def new
  @user = User.new
end

def create
  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    flash[:success] = "Welcome #{@user.username} to the Alpha-Blog. Thanks for signing up."
    redirect_to user_path(@user)
  else
    render 'new'
  end
end

def edit
  if !logged_in? 
    flash[:danger] = "You must login to perform this action"
    redirect_to login_path
  end
end

def update
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

def show 
  @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
end

def destroy
  @user = User.find(params[:id])
  @user.destroy
  flash[:danger] = "User and all articles created by the user have been deleted"
  redirect_to users_path
end

private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def require_same_user
    if !logged_in? 
      flash[:danger] = "You must login to update your own profile"
      redirect_to articles_path
    elsif logged_in? && current_user != @user && !current_user.admin?
      flash[:danger] = "You can ONLY update your own profile"
      redirect_to articles_path
    end
  end
  def require_admin
    if logged_in? && !current_user.admin?
       flash[:danger] = "Only admin users can perform that action"
       redirect_to root_path
     end 
  end
end