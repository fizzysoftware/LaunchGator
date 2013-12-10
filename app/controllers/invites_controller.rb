class InvitesController < ApplicationController
  before_filter :valid_site, :only=>[:create,:index]
  before_filter :authorize, :only => [:index]
  before_filter :validate_referal_code, :only=>[:referral]

  def index
    @invites = @site.invites.paginate(:page => params[:page], :per_page=> 15)
    @daily_reports = DailyReport.where('site_id = ?',params[:site_id]).order("created_at ASC")
    respond_to do |format|
      format.html # index.html.erb
      format.xls
    end
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

    if Rails.env.development?
      url = "http://" + site_domain + ".launch.lvh.me:3000" + "?referral_code=" + params[:id]
    else
      url = @referee.site.url + "?referral_code=" + params[:id]
    end

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

  def authorize
    unless current_user.present? and @site.user_id == current_user.id
      flash[:error] = "You are not authorized for this."
      redirect_to(root_path)
    end
  end

end
