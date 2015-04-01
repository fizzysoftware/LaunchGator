class SitesController < ApplicationController
  before_filter :authorize, :only=>[:edit, :update]
  before_filter :super_admin_acces, :only=>[:index]
  before_filter :validate_subdomain, :only=>[:view]
  before_filter :sterilize_url, :only => [:update, :create]

  def index
    @sites = Site.paginate(:page => params[:page], :per_page=> 50)
  end

  def edit
    @site.build_image if @site.image.nil?
    if params[:tab]
      @active_tab = params[:tab].split(" ")
      @active_tab = @active_tab[0]
    end
    @active_tab
  end

  def update
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
    @visited = site_visited_or_not(@site.id)
    @invite = Invite.new
  end

  def check_domain_propagated
    @site = current_user.site if current_user.present?
    if @site.domain_mapped? == true
      @site.update_attributes(:domain_propagated => 1, :state => 3)
      redirect_to edit_site_path(@site), notice: "congratulations Your site is working now start sharing it and collect signup."
    else
      @site.update_attribute(:domain_propagated, 0)
      redirect_to edit_site_path(@site), :flash => {:error => "Please check your cname setting is it pointing to host.deskgator.com"}
    end
  end

  private

  def authorize
    begin
      @site = Site.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "This record does not exist."
      redirect_to(root_path)
    else
      unless current_user.present? and @site.user_id == current_user.id
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
      subdomain = request.subdomain.to_s.gsub('.launch','')
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

  def sterilize_url
    params[:site][:url] = params[:site][:url].chop  if params[:site][:url].last == "/"
  end

end
