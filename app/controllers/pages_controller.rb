class PagesController < ApplicationController
  def home
    # if user logged in then when it go to home then redirect to articles listing page.
    redirect_to articles_path if logged_in?
  end

  def about
  end
end
