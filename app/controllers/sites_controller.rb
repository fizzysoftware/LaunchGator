class SitesController < ApplicationController
  before_filter :authorize, :only=>[:edit, :update]
  # before_filter :super_admin_acces, :only=>[:index]
  before_filter :validate_subdomain, :only=>[:view]

  def index
    @sites = Site.all
  end

  def edit  
    @site = Site.find(params[:id])
    @site.build_image if @site.image.nil?
    if params[:tab]
      @active_tab = params[:tab].split(" ")
      @active_tab = @active_tab[0]
    end
    @active_tab
  end

  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(params[:site])
      if !@site.image.nil?
        @site.image.update_colums(params)
      end
      @site.parse_domain_name_from_url
      flash[:notice] = "Site was successfully updated."
       redirect_to(edit_site_path(@site)) 
    else 
      @site.build_image if @site.image.nil?  
      render :action => "edit" 
    end
  end  

  def view 
    @site.update_attribute(:clicks, @site.clicks+1)
    #@visited = site_visited_or_not(@site.id)
    #@invite = Invite.new
  end 

  private

  def authorize
    begin
      @site = Site.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "This record does not exist."
      redirect_to(root_path)
    else
      unless @site.user_id == current_user.id
        flash[:error] = "You are not authorized for this."
        redirect_to(root_path)
      end  

    end
  end 

  def no_delete_for_default_site
    if params[:id]==1
      redirect_to(root_path)
    end
  end  

  def validate_subdomain
    if request.subdomain.to_s  != "launch"
      p subdomain = request.subdomain.to_s.gsub('.launch','')
      begin
        @site = Site.find_by_domain_name!(subdomain)
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "This record does not exist."
        redirect_to(root_path(:subdomain=>false))
      end
    else
      @site = Site.find(1)  
    end
  end 

end
