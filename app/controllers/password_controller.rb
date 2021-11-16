class PasswordController < ApplicationController
    def forget_password
        if request.post?
            @user = User.find_by_email(params[:email])
            if @user
                new_password = generate_password
                @user.update(:password => new_password)
                SendNewPasswordMailer.send_generated_password(@user.email, new_password).deliver
                redirect_to :controller => "account", :action => "login"
            else
                flash[:notice] = "Invalid Email! Please Enter correct Email"
                redirect_to :action => :forget_password 
            end
        end
    end

    def reset_password
        begin
            @user = User.find(session[:user])	
            if request.post?			
                if @user
                @user.update(:password=>params[:password])
                #SendNewPasswordMailer.send_generated_password(@user.email, params[:password]).deliver
                flash[:notice] = "Your password has been reset"
                redirect_to :controller => "account", :action => "login"
                else
                    redirect_to :action => "reset_password"
                end
            end   
        rescue Exception => e
            puts e
            flash[:notice] = "login first to reset your password"
            redirect_to :controller => "account", :action => "login"
            
        end
    end


    private

    def generate_password
        (0...8).map{65.+(rand(25)).chr}.join
    end
end
