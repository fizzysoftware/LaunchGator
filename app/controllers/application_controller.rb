class ApplicationController < ActionController::Base
  
  #When I wrote this, only God and I understood what I was doing
  #Now, God only knows
  
  http_basic_authenticate_with :name => "fizzysoftware", :password => "fizzysoftware"  if ENV["RAILS_ENV"] == "staging"
  before_filter :authenticate_user!
  
  private

end
