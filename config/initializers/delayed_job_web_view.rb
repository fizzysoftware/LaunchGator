if Rails.env.production?
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    username == 'launch_gator' && password == 'launch_gator'
  end
end
