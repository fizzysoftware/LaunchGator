if Rails.env.production?
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    username == 'basic_module' && password == 'basic_module'
  end
end
