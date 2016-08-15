class CategoriesController < ApplicationController
before_action :set_category, only: [:edit, :update, :show, :destroy]
#before_action :require_user, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    
    if @category.save
      flash[:success] = "Category was successfuly created."
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    
  end

  def show
  end

  def destroy
    
  end

  def delete
    
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
  def set_category
    @category = Category.find(params[:id])
  end
end