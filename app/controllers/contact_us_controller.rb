class ContactUsController < ApplicationController
  skip_before_filter :login_check
  
  def new
    @contact_u = ContactU.new 
    respond_to do |format|
      format.html # new.html.erb
    end
  end

 
  def create
    @contact_u = ContactU.new(params[:contact_u])
    respond_to do |format|
      if @contact_u.save
        format.html { redirect_to(contact_path, :notice => 'Thanks for droping a line.We will be contacting you soon.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

 
end
