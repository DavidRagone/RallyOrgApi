require File.expand_path('../../lib/rally_org_api.rb', __FILE__)

Rspec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true
  #
  #     # Use color not only in STDOUT but also in pagers and files
  config.tty = true
  #
  #         # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end
