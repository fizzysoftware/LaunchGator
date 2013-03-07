class InvitesController < ApplicationController
  # skip_before_filter :login_check, :only=>[:create, :referral]
  before_filter :valid_site, :only=>[:create]
  before_filter :validate_referal_code, :only=>[:referral]
  # before_filter :login_may_be, :only=>[:create, :referral]
  
  def index
    @site = Site.find_by_id(params[:site_id])
    @invites = @site.invites.paginate(:page => params[:page], :per_page=> 15)
    #@daily_reports = DailyReport.where('site_id = ?',params[:site_id]).order("created_at ASC")
  end


  def create
    invite = Invite.get_invite_code_for_email_and_site(@site.id,params[:email],params[:referral_code])
    cookies[:invite] = { :value => invite.cookie, :expires => 1.year.from_now }
    render :text => invite.short_url
  end


  def referral
    site_domain = @referee.site.domain_name
    @referee.views_count = @referee.views_count + 1
    @referee.save
    #DailyReport.daily_view_counter(@referee.site_id)
   
    # for local machine replace domain with .launch.lvh.me:3000
   # url = "http://" + site_domain + ".launch.deskgator.com" + "?referral_code=" + params[:id]
    url = "http://" + site_domain + ".launch.lvh.me:3000" + "?referral_code=" + params[:id]
    
    redirect_to url

  end

  private

  def validate_referal_code
    @referee = Invite.find_by_unique_code(params[:id]) 
    unless @referee
      flash[:error] = "This referral code does not exist."
      redirect_to(root_path)
    end    
  end 

  def valid_site
    begin
      @site = Site.find_by_id(params[:site_id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "This record does not exist."
      redirect_to(root_path)
    end
  end

end