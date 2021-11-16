class HomeController < ApplicationController
  def dashboard
    begin
      @user_data = User.find(session[:user])
    rescue => exception
      flash[:notice] = "You are not logged in"
      redirect_to :controller => "account", :action => "login"
    end
  end
end
