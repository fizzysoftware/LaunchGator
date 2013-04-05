task :add_data => :environment do
  user=User.new(:email=>'aggarwalsudhanshu@gmail.com', :password=>'fizzyld0710',:account_type=> "super_admin", :full_name=>'Sudhanshu Aggarwal')
  user.save(:validate=>false) 
  
  s = Site.new(:user_id=>1 ,:email=>'aggarwalsudhanshu@gmail.com',:name=>'Launchdaddy',:url=>'http://www.launchgator.com', :tagline=>'Create your viral page in minutes',:description=>'Create your viral page in minutes',:twitter=>'launchgator')   
  s.save
end
