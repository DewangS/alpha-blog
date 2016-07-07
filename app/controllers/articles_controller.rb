class ArticlesController < ApplicationController

def index
  @articles = Article.all
end
def new
  @article = Article.new
end
def create
  #render plain: params[:article]
  @article = Article.new(article_params)
  if @article.save
    flash[:success] = "Article was successfuly created."
    redirect_to article_path(:id => @article.id)
  else
    @article.errors.full_messages.each do |msg|
      flash[:error] = @article.errors.full_messages
    end 
    @article.errors.clear
    render 'new'
  end
end
def show
  @article = Article.find(params[:id])
  render :show
end

def edit
    @article = Article.find(params[:id])
    #render :edit
end

def update
  @article = Article.find(params[:id])
  if @article.update(article_params)
    flash[:success] = "Article was successfuly updated."
    redirect_to article_path(:id => @article.id)
  else
    @article.errors.full_messages.each do |msg|
      flash[:error] = @article.errors.full_messages
    end 
    @article.errors.clear
    render 'edit'
  end
end

def delete
    
end

def destroy
  article = Article.find(params[:id]).destroy
  flash[:notice] = "Article '#{article.title}' successfully deleted."
  redirect_to articles_path
end

private
def article_params
  params.require(:article).permit(:title, :description)
end
end