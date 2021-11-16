class AccountController < ApplicationController
    def login
        if request.post?
            @user = User.authenticate(params[:email], params[:password])
            if @user
                session[:user] = @user.id
                flash[:notice] = "You are logged in"
                redirect_to :controller => "home", :action => "dashboard"
            else
                flash[:notice] = "email/password didn't match"
                render :login
            end
        end
    end


    def signup
        if request.post?
            @new_user = User.new(user_params)
            if @new_user.save
                # TODO Action Mailer to be Implemented
                flash[:notice] = "Your Account Has been Created! Check your Email"
                redirect_to :action => "login"
            else
                render :signup
            end
        end
    end


    def logout
        flash[:notice] = "You have successfully logged Out"
        session[:user] = nil
        redirect_to :action => "login"
    end

    private
    def user_params
        params.permit(:first_name, :last_name, :email, :mobile, :date_of_birth, :password, :hashed_password)
    end
end
