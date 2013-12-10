module ApplicationHelper
	def active_class(action,action_match)
	  if action == action_match
	    'signupbtn'
	  else
	    nil
	  end
	end

  def from_session_if_present(user)
    checked_email = session[:checked_email]
    session[:checked_email] = nil
    checked_email and user.email.blank? ? checked_email : user.email
  end
end
