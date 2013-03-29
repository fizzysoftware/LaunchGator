## Development Setup

### Clone the repo and make a copy to start the new application
```
git clone git@bitbucket.org:nikhil_kathuria89/launch_gator.git
```

### Install dependencies (ensure bundler is installed)
```
cd launch_gator
bundle install
```

CREATE database config (sample config is in config/database.sample.yml)
```
cp config/database_sample.yml config/database.yml
# make the appropirate changes 


```

Setup DB
```
rake db:create
rake db:migrate
rake db:seed
```


Start the Server
```
rails s
```

For Background Jobs(Sending mail etc)
```
rake jobs:work
```


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