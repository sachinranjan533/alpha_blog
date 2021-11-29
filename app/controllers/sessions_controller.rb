class SessionsController < ApplicationController
    def new
    end
    def create
        # getting user info by email id
        user=User.find_by(email: params[:session][:email].downcase)
        # checking user exist or not and there password
        if user && user.authenticate(params[:session][:password])
            #creating a session for particular user
            session[:id]=user.id
            flash[:notice]="Successfully Logged In"
            redirect_to user
        else
            # flash persist for one cycle of http request and redirect take one
            # cycle of http request but here render is not a new request to 
            # new page.That's why I use flash.now
            flash.now[:alert]="Not valid login credentials"
            render 'new'
        end
    end
    def destroy
        # Logout from the particular session
        session[:id]=nil
        flash[:notice]="Logged Out"
        redirect_to root_path
    end
end
