# README

This README would normally document whatever steps are necessary to get the
application up and running.


## Ruby version

```
- 5.0.1
```

## Getting started

Using Windows 10. Use Vagrant to run rails through a virtual linux box

See https://gorails.com/guides/using-vagrant-for-rails-development

****Code for Vagrantfile:****

VAGRANTFILE_API_VERSION = "2"
REQUIRED_PLUGINS        = %w(vagrant-vbguest vagrant-librarian-chef-nochef)

plugins_to_install = REQUIRED_PLUGINS.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing required plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting. Please read the Bike Index README."
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"

  # Configure the virtual machine to use 1.5GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1536"]
  end

  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "build-essential"
    chef.add_recipe "system::install_packages"
    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv::user"
    chef.add_recipe "ruby_rbenv::user_install"
    chef.add_recipe "vim"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "postgresql::client"

    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'ubuntu',
          rubies: ["2.4.0"],
          global: "2.4.0",
          gems: {
          "2.4.0" => [{ name: "bundler" }]
        }
        }]
      },
      system: {
        packages: {
          install: ["redis-server", "nodejs", "libpq-dev"]
        }
      },
      postgresql: {
        :pg_hba => [{
          :comment => "# Add vagrant role",
          :type => 'local', :db => 'all', :user => 'ubuntu', :addr => nil, :method => 'trust'
        }],
        :users => [{
          "username": "ubuntu",
          "password": "",
          "superuser": true,
          "replication": false,
          "createdb": true,
          "createrole": false,
          "inherit": false,
          "login": true
        }]
      }
    }
  end
end

```
To get started with the app, clone the repo and then install the needed gems:
 
 -------START--------
 
source 'https://rubygems.org'

gem 'rails',                   '5.0.2'
gem 'bcrypt',                  '3.1.11'
gem 'faker',                   '1.6.6'
gem 'carrierwave',             '0.11.2'
gem 'mini_magick',             '4.5.1'
gem 'fog',                     '1.38.0'
gem 'will_paginate',           '3.1.0'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'bootstrap-sass',          '3.3.6'
gem 'puma',                    '3.4.0'
gem 'sass-rails',              '5.0.6'
gem 'uglifier',                '3.0.0'
gem 'coffee-rails',            '4.2.1'
gem 'jquery-rails',            '4.1.1'
gem 'turbolinks',              '5.0.1'
gem 'jbuilder',                '2.4.1'

group :development, :test do
  gem 'sqlite3', '1.3.12'
  gem 'byebug',  '9.0.0', platform: :mri
end

group :development do
  gem 'web-console',           '3.1.1'
  gem 'listen',                '3.0.8'
  gem 'spring',                '1.7.2'
  gem 'spring-watcher-listen', '2.0.0'
end

group :test do
  gem 'rails-controller-testing', '0.1.1'
  gem 'minitest-reporters',       '1.1.9'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end

group :production do
  gem 'pg',   '0.18.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

------- END -------- 


$ bundle install --without production

```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```
