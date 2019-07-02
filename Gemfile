
git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }
source "https://rubygems.org"

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all' #=> Helps to load dependencies
gem 'sqlite3'
gem 'thin'
gem 'shotgun'
gem 'pry'
gem 'bcrypt'
gem "tux"
gem 'rspec-print_failures_eagerly'
gem 'rest-client', '~> 2.0', '>= 2.0.2'
gem 'httparty', '~> 0.17.0'
gem 'will_paginate', '~> 3.1', '>= 3.1.5'
gem 'coderay', '1.1.2'
gem 'byebug', '10.0.2'
gem 'faker', '~> 1.6', '>= 1.6.6'

group :test do
    gem 'rspec'
    gem 'rack-test'
    gem 'capybara'
    gem 'selenium-webdriver'
    gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
