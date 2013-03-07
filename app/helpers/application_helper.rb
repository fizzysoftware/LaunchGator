module ApplicationHelper
	def active_class(action,action_match) 
	  if action == action_match
	    'signupbtn'
	  else
	    nil
	  end
	end
end
