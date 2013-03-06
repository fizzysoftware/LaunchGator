class ApplicationController < ActionController::Base
  
  #When I wrote this, only God and I understood what I was doing
  #Now, God only knows
  
  http_basic_authenticate_with :name => "fizzysoftware", :password => "fizzysoftware"  if ENV["RAILS_ENV"] == "staging"
  #before_filter :authenticate_user!
  
  private

  # def after_sign_in_path_for(current_user)
  #   manage_path
  # end
  
  def after_sign_out_path_for(resource_or_scope)
  	
    root_path
  end

end
