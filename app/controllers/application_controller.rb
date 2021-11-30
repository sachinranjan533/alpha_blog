class ApplicationController < ActionController::Base

    # defining methods as helper_methods for view

    helper_method :current_user,:logged_in?

    # methods define in application_controller is available to all the controllers.

    def current_user
        # if current user is logged in then it's details is stored in session
        # and we can get information about user.

        # || if value exist then return that else return nil.
        @current_user ||=User.find(session[:id]) if session[:id]
    end

    def logged_in?
        # !! convert any value to true and false.
        !!current_user
    end

end
