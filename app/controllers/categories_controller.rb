class CategoriesController < ApplicationController

    def new
        @category = Category.new
    end
  
    def index
  
    end
  
    def show
  
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