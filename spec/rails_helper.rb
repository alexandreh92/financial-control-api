# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }
require 'pry'
require 'rspec/json_expectations'
require 'rspec/rails'

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!
ActiveJob::Base.queue_adapter = :test

RSpec.configure do |config|
  # Clears terminal output before starting new spec
  config.before :suite do
    puts `clear && printf "\e[3J"`
  end

  config.fixture_path = Rails.root.join('spec/fixtures')
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!
  config.include Rails.application.routes.url_helpers
end
