class SessionsController < Devise::OmniauthCallbacksController
  
  def all
    user = User.from_omniauth(env["omniauth.auth"])
    if user.persisted?
      sign_in_and_redirect(user)
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end    
    
  end
  
  alias_method :facebook, :all
end