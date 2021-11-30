class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user,except: [:show,:index]
  before_action :require_same_user,only: [:edit,:update]

  def show
  end

  def index
    @articles = Article.all.paginate(page: params[:page], per_page: 2)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user=current_user # calling current_user helper methods
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article
    else
      render "new"
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  #checking whether articel which is editing is his own article.If not he cannot edit.
  def require_same_user
    if @article.user!=current_user
      flash[:notice]="You can edit your own article and not others article"
      redirect_to article_path(@article)
    end
  end
end