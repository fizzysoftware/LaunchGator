## Development Setup

### Clone the repo and make a copy to start the new application
```
git clone git@bitbucket.org:fizzysoftware/basic_module.git
```

### Install dependencies (ensure bundler is installed)
```
cd basic_module
bundle install
```

CREATE database config (sample config is in config/database.sample.yml)
```
cp config/database.yml.samle config/database.yml
# make the appropirate changes 
Search in the whole application.

1. Replace basic_module with namespace of your application like my_awesome_app
2. Replace BasicModule with namespace of your application name MyAwesomeApp



```

Setup DB
```
rake db:create
```

rake db:migrate
```

rake db:seed
```

Start the Server
```


# Administration

You can access the admin console by visiting http://localhost:3000/admin
with the below credentials:

* user: sudhanshu@fizzysoftware.com
* pass: testing

* user: mohit@fizzysoftware.com
* pass: testing


Testing emails:

config.action_mailer.smtp_settings = {
   address: "smtp.gmail.com",
   port: 587,
   domain: "basic_module.com",
   authentication: "plain",
   enable_starttls_auto: true,
   user_name: "juggernaut789@gmail.com",
   password: "mohitjain"
 }


#Mailcatcher gem:
 
mailcatcher
Starting MailCatcher
==> smtp://127.0.0.1:1025
==> http://127.0.0.1:1080
*** MailCatcher runs as a daemon by default. Go to the web interface to quit. ie http://127.0.0.1:1080

#act_as_countable module

This is a module which will be used to display graphs in admin panel. 

#reminder module

This modules send reminder emails to users which are not coming in certain time interval.


#Production list

Basic Guidelines before going to production mode.

These are the some basic guidelines I always follow before launching a ruby on rails application.

1. Compress all image with smusher gem.
2. Intergrate DelayedJob Web View if you are using Delayed job.
3. Enable action caching when needed.
4. Update Read me file of your project. It should be descriptive. Examples: Delayed Job
5. Compress js and css
6. Integrate Airbrake
7. Make Sure facebook and twitter or any other social login applications have proper logos, descriptions etc.
8. Facebook Login should be in a  pop up.
9. Check Gtmetrics rating and fix them.
10. Integrate New Relic
11. Logs files should be rotated
12. Add proper database indexes.
13. Configure timezone of your server based upon the client requirements.
14. Use handle_asynchronously in delayed job for email sending and lot of other call backs or methods to optimise performance.
15. Store all the data what ever you can.
16. Proper comments should be there.
17. Place google analytics code.
18. Test on all the major browsers which includes Firefox, Chrome, Internet Explorer, Safari
19. Save images with interlace if you are using too many images in the website.
20. Add cache control headers
21. Make sure you have a contact us page
22. If user don’t comes back after 3 days send him a reminder  It should be a personal email and take this email seriously

