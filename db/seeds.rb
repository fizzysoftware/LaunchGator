# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(:email => 'user@fizzysoftware.com', :password => 'testing', :password_confirmation => 'testing')

user = User.new(:email => 'user@gmail.com', :password => 'testing', :account_type => "super_admin", :full_name => 'Sudhanshu Aggarwal')
user.save(:validate=>false)
site = Site.new(:user_id => 1 , :email=>'user@gmail.com', :name=>'Launchdaddy', :url => 'http://www.launchgator.com', :tagline => 'Create your viral page in minutes', :description => 'Create your viral page in minutes', :twitter => 'launchgator')
site.save
