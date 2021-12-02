class CategoriesController < ApplicationController

    before_action :require_admin,except: [:index,:show]
    def new
        @category = Category.new
    end
  
    def index
        @categories=Category.all.paginate(page: params[:page], per_page: 2)
    end
  
    def show
        @category=Category.find(params[:id]) #finding category based on ID.
    end
    
    # creating action create.
    def create
        @category=Category.new(params.require(:category).permit(:name))
        if @category.save
            flash[:notice] = "Category was successfully created"
            redirect_to @category
        else
            render 'new'
        end
    end
end 

private

def require_admin
    if !(logged_in? && current_user.admin?) # if not user then cannot perform new and create category
        flash[:notice]="Only user can perform this action"
        redirect_to categories_url
    end
end