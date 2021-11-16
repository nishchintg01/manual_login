class ProfileController < ApplicationController
    def edit_profile
        begin
            @user_data = User.find(session[:user])
            if request.post?
                @user_data.update(profile_params)
                @user_data.image.attach(params[:image])
                @user_data.save
                puts params
                puts "=================================================================="
                puts profile_params
            end   
        rescue Exception => e
            puts e
            flash[:notice] = "Try Logging In Again"
            redirect_to :controller => 'account', :action => 'login'
        end
    end

    private
    def profile_params
        params.permit(:first_name, :last_name, :date_of_birth, :mobile, :email, :image)
    end
end
