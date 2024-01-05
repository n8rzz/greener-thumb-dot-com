# This file contains configurations for RSpec, FactoryBot, and DatabaseCleaner for testing in Rails.
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'factory_bot_rails'
require 'database_cleaner'

# This block contains configurations for RSpec.
RSpec.configure do |config|
  # This line includes the syntax methods from FactoryBot so they can be used in the tests.
config.include FactoryBot::Syntax::Methods

  # This block sets up the DatabaseCleaner strategy to be used before the test suite runs.
config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  # This block ensures that the database is cleaned around each test example.
config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # This line infers the type of spec from the file location.
config.infer_spec_type_from_file_location!
  # This line filters Rails from the backtrace.
config.filter_rails_from_backtrace!
end
