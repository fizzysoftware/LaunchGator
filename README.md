# LaunchGator


### The open source, self-hosted site builder


LaunchGator is a tool for creating awesome coming soon pages for your upcoming website.


<table>
  <tr>
    <td align="center">
      <a href="http://launch.deskgator.com/images/Landing.png" target="_blank" title="Landing Page">
        <img src="http://launch.deskgator.com/images/Landing.png" alt="Landing Page">
      </a>
      <br />
      <em>Landing Page</em>
    </td>
    <td align="center">
      <a href="http://launch.deskgator.com/images/site_page_created.png" target="_blank" title="Page Created">
        <img src="http://launch.deskgator.com/images/site_page_created.png" alt="Site Page Created">
      </a>
      <br />
      <em>Site Page Created</em>
    </td>
  </tr>
</table>

## Development Setup

### Clone the repo and make a copy to start the new application
```
git clone https://github.com/fizzysoftware/LaunchGator.git
```

### Install dependencies (ensure bundler is installed)
```
cd LaunchGator
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

Run Rake Tasks
```
rake add_data
```

Start the Server
```
rails s
```

For Background Jobs(Sending mail etc)
```
rake jobs:work
```

Demo
----

There is a demo available at [http://launch.deskgator.com/](http://launch.deskgator.com/)


Deploying:
----------

  * Change the `config/deploy.rb` accordingly.
  * Setup server and deploy

```bash
cap production deploy:setup
cap production deploy:cold
```

Copyright
---------

Copyright (c) 2012-2013 Fizzy Software. See LICENSE for details.
