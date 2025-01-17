source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

gem 'rails-controller-testing'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# used for admin log in
gem 'bcrypt', '~>3.1.7'

gem 'devise'

gem 'rspec-activemodel-mocks'

group :development, :test, :production do
  gem 'rspec-rails', '~> 3.8'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '~> 5.0'
  gem 'database_cleaner'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem "binding_of_caller"

end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Beautifying
gem 'haml'
gem 'bootstrap', '~> 4.3.1'
gem "autoprefixer-rails"
gem 'jquery-rails'
gem 'bootstrap-glyphicons'
gem 'jquery-turbolinks'
gem 'tinymce-rails', '~> 4.3', '>= 4.3.13'


group :production do
  gem 'rails_12factor'  # Heroku-specific production settings
end

# setup Cucumber, RSpec, Guard support
group :test do
  #gem 'rspec-rails', :require =>  false
  gem 'guard-rspec'
  gem 'simplecov', :require => false
  gem 'cucumber-rails', :require => false
  gem 'selenium-webdriver', '~> 4.0.0.rc1'
  # gem 'database_cleaner' # required by Cucumber
  gem "rspec"
  #gem 'factory_girl_rails', :require => false # if using FactoryGirl
  gem 'metric_fu'        # collect code metrics
  gem 'codeclimate-test-reporter'
  gem 'coveralls'
  gem 'simplecov-console'
end
