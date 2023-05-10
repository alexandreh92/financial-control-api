# frozen_string_literal: true

require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec/fixtures/vcr_cassetes')
  c.hook_into :webmock
  c.ignore_localhost = true
  c.configure_rspec_metadata!

  # Filter Rails secrets that are strings or numbers
  secrets_to_filter = Rails.application.secrets.select do |_key, value|
    value.is_a?(String) || value.is_a?(Numeric)
  end

  secrets_to_filter.each do |key, value|
    c.filter_sensitive_data("<#{key.upcase}>") { value }
  end
end

RSpec.configure do |config|
  # Enables VCR only if have :vcr flag
  config.around do |ex|
    if ex.metadata.key?(:vcr)
      WebMock.disable_net_connect!(allow: 'notify.bugsnag.com')
      ex.run
    else
      WebMock.allow_net_connect!
      VCR.turned_off { ex.run }
    end
  end
end
