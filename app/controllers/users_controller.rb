class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    debugger
    if params[:home_page]
       @user = User.find_by_email(params[:user][:email])
       if @user
          @title = "Launchgator - Enter your login details"
          redirect_to new_user_session_path
       else 
         @user = User.new(params[:user])   
         @title = "Launchgator - Create an account"
         redirect_to new_user_registration_path
       end  
    end 
  end

  def home

  end

end
