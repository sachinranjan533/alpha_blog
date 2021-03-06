class UsersController < ApplicationController
    before_action :set_user, only: [:show,:edit,:update,:destroy]
    before_action :require_user, only: [:edit,:update]
    before_action :require_same_user, only: [:edit,:update,:destroy]

    def show
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
    end
    def update
        if @user.update(params.require(:user).permit(:username,:email,:password))
            flash[:notice]="User data updated successfully"
            redirect_to users_path
        else
            render 'edit'
        end
    end

    #adding destroy method for delete

    def destroy
        @user.destroy
        # destroying the session of particular user if it is current user deleting the profile
        session[:id]=nil if @user==current_user # not equal if admin is deleting someoe else account
        flash[:notice]="Account and all related articles is deleted."
        redirect_to articles_path
    end

    private

    def set_user
        @user=User.find(params[:id])
    end

    #checking whether profile which is editing is his own profile.If not he cannot edit.
    # redirect if current user is not admin
    def require_same_user
        if @user!=current_user and !current_user.admin?
            flash[:notice]="You can only edit or delete your own profile"
            redirect_to user_path
        end
    end
end