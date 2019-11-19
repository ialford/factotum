source 'http://rubygems.org'

group :application do
  gem 'rails', '~> 4.2.10'

  gem 'active_attr'
  gem 'american_date'
  gem 'devise'
  gem 'exception_notification', "~> 4.0.0"
  gem 'hesburgh_assets', :git => 'git@github.com:ndlib/hesburgh_assets.git'
  gem 'google_drive'
  gem 'jquery-ui-rails'
  gem 'json'
  gem 'kaminari'
  gem 'mechanize'
  gem 'money'
  gem 'mysql2', '~> 0.4.7'
  gem 'net-ldap'
  gem 'paperclip', '~> 5.2.0'
  gem "rb-readline"
  gem 'redcarpet'
  gem 'simple_form'
  gem 'worldcat'
  gem 'therubyracer'

  # Okta
  gem 'omniauth-oktaoauth'

  gem 'backgroundrb-rails3', :require => 'backgroundrb'

  gem "twitter-bootstrap-rails"
  gem 'jquery-datatables-rails'

  # for static pages
  gem 'high_voltage', '~> 2.2.1'

  gem 'rake', '>= 10.0.3'

  gem 'newrelic_rpm'

  # update sprockets
  gem "sprockets", "~> 2.12.5"

  # update ffi
  gem "ffi", ">= 1.9.24"

  # update nokogiri
  gem "nokogiri", ">= 1.8.2"

  # update loofah
  gem "loofah", ">= 2.2.1"

  # For Errbit
  gem "airbrake", "4.3.0"

  gem 'sass-rails', '~> 4.0.5'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'uglifier', ">= 1.3.0"
  gem "pagedown-bootstrap-rails"
  gem "bootstrap-sass", "~> 3.4.1"
  gem "font-awesome-rails"
  gem "sentry-raven", "~> 2.7"

  # For ILL Terms integration
  gem "faraday"
  gem "faraday_middleware"
end

# For deployment from a CI server
group :deployment do
  # Use Capistrano for deployment
  gem "capistrano", "~> 3.11"
  gem "capistrano-rails", "~> 1.1"
  gem "capistrano-maintenance", "~> 1.0"
  gem "whenever", :require => false
end

group :development do
  gem "better_errors"
  gem 'sextant'
end

group :development, :test do
  gem 'pry-rails' # Debugger replacements.  Use "binding.pry" where you would use "debugger"
  gem 'activerecord-nulldb-adapter'
  gem 'database_cleaner'
  gem 'email_spec'

  gem "debugger2"
  gem "rspec-rails"
  gem "capybara"
  gem "factory_girl_rails", :require => false
  gem "faker"
  gem "spork"

  gem 'ruby-prof'
end

group :test do
  gem 'vcr'
  gem 'webmock'
end
