class UsersController < ApplicationController
    def show
        @user=User.find(params[:id])
        @articles=@user.articles.paginate(page: params[:page], per_page: 2)
    end
    def index
        @users=User.all.paginate(page: params[:page], per_page: 2)
    end

    def new
        @user=User.new
    end
    def create
        @user=User.new(params.require(:user).permit(:username,:email,:password))
        if @user.save
            flash[:notice]="Welcome to the Alpha Blog #{@user.username}"
            redirect_to users_path
        else
            render 'new'
        end
    end
    def edit
        @user=User.find(params[:id])
    end
    def update
        @user=User.find(params[:id])
        if @user.update(params.require(:user).permit(:username,:email,:password))
            flash[:notice]="User data updated successfully"
            redirect_to users_path
        else
            render 'edit'
        end
    end
end
