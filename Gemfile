source 'https://rubygems.org'
ruby "2.2.1"

 # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
 gem 'rails', '4.2.5'

 # #1
 group :production do
   #Heroku only supports Postgres, so we use pg in our Production environment.
   gem 'pg'
   #Rails 4 requires some minor configuration changes to properly serve assets on Heroku
   gem 'rails_12factor'
 end

 # #2
 group :development do
   #use sqlite3 for our Development environment because it is an easy to use database perfect for rapid testing
   gem 'sqlite3'
   # Adding Pry (Assignment 29) which adds extra features unavailable in IRB shell
   gem 'pry-rails'
 end

 group :development, :test do
   gem 'rspec-rails', '~> 3.0'
   gem 'nyan-cat-formatter'
   gem 'shoulda'
   gem 'factory_girl_rails', '~> 4.0'
   gem 'byebug'
 end
 # Use SCSS for stylesheets
 gem 'sass-rails', '~> 5.0'
 # Use Uglifier as compressor for JavaScript assets
 gem 'uglifier', '>= 1.3.0'
 # Use CoffeeScript for .coffee assets and views
 gem 'coffee-rails', '~> 4.1.0'
 # Use jquery as the JavaScript library
 gem 'jquery-rails'
 # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
 gem 'turbolinks'
 # Install bootstrap
 gem 'bootstrap-sass'
 # Install BCrypt to encrypt passwords for users
 gem 'bcrypt'

 # Install Figaro to protect sensitive app information on GitHub
 gem 'figaro', '1.0'
