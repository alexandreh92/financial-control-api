# frozen_string_literal: true

require 'simplecov'

# Simplecov
SimpleCov.start 'rails' do
  add_group 'Services', 'app/services'
  add_group 'Library', 'app/lib'

  add_filter %w[channels jobs mailers uploaders helpers]
end
