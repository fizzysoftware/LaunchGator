ActiveAdmin.register_page "Dashboard" do
  sidebar :help do
    ul do
         li "Stuck? Contact your manager"
         li "or drop a mail at mohit@fizzysoftware.com"
    end
  end

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #      span :class => "blank_slate" do
    #        span "Welcome to Active Admin. This is the default dashboard page."
    #        small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
    #      end
    #    end

    # Here is an example of a simple dashboard with columns and panels.
    #
        
  end
end
