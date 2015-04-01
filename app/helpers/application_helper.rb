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

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def active_or_inactive_domain(site_url)
    if site_url.persisted?
      site_url.active ? "active" : "inactive"
    end
  end
end
