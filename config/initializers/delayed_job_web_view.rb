if Rails.env.production?
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    username == 'username' && password == 'password'
  end
end
