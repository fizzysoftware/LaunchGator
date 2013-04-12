set :stages, %w(production)     #various environments
load "deploy/assets"                    #precompile all the css, js and images... before deployment..
require "bundler/capistrano"            # install all the new missing plugins...
require 'capistrano/ext/multistage'     # deploy on all the servers..
require "rvm/capistrano"                # if you are using rvm on your server..
require './config/boot'           
#require 'delayed/recipes'               # load this for delayed job..
#require "whenever/capistrano"
#require 'airbrake/capistrano'

before "deploy:assets:precompile","deploy:config_symlink"
#before "deploy:update_code",    "delayed_job:stop"  # stop the previous deployed job workers...
after "deploy:update", "deploy:cleanup" #clean up temp files etc.
after "deploy:update_code","deploy:migrate"
#after "deploy:create_symlink", "deploy:update_crontab"
#after "deploy:start",   "delayed_job:start" #start the delayed job 
#after "deploy:restart", "delayed_job:restart" # restart it..

#set :whenever_command, "bundle exec whenever"
set(:application) { "launchgator" }
#set :delayed_job_args, "-n 2"            # number of delayed job workers 
set :rvm_ruby_string, '1.9.3'             # ruby version you are using...
set :rvm_type, :user
set :whenever_environment, defer { stage }  # whenever gem for cron jobs...          
set :whenever_identifier, defer { "#{application}_#{stage}" }   
server "192.155.90.129", :app, :web, :db, :primary => true 
set (:deploy_to) { "/home/fizzy/#{application}/#{stage}" }
set :user, 'fizzy'
set :keep_releases, 3
set :repository, "git@bitbucket.org:nikhil_kathuria89/launch_gator.git"
set :use_sudo, false
set :scm, :git
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :git_enable_submodules, 1

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :config_symlink do
    run "ln -sf #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
  # task :update_crontab, :roles => :db do
  #  run "cd #{release_path} && bundle exec whenever --update-crontab #{application}"
  # end
end