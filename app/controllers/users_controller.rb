class UsersController < ApplicationController

    before_filter :super_admin_acces, :only=>[:index]

    def index
        @users = User.all
    end

    def check_user
        @user = User.find_by_email(params[:user][:email])
        if @user.present?
            redirect_to new_user_session_path
        else 
            @user = User.new(params[:user])   
            redirect_to new_user_registration_path
        end  
    end

    def home
        if user_signed_in? 
            @user = current_user
            @site = @user.site
            redirect_to edit_site_path(@site)
        else
            @site.update_attribute(:clicks, @site.clicks+1)   
       end
   end

end