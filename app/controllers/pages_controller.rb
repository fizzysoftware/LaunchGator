class PagesController < ApplicationController
   skip_before_filter :login_check
  def about
  end

  def terms
  end

  def privacy_policy
  end
 

end

