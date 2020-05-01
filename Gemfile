source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# We use faucet-pipeline instead of webpacker
gem 'faucet_pipeline_rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'aasm'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'

  gem 'rubocop', require: false
  gem 'rubocop-gitlab-security', require: false
  gem 'rubocop-minitest', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  # NOTE Keep parser version in sync with Ruby version.
  #      This is not a MUST but will reduce warnings and
  #      other issues, mostly with Rubocop.
  gem 'parser', '~> 2.7.1'
end

group :test do
  gem 'minitest-spec-rails'
  gem 'minitest', '~> 5.13.0' # FIXME https://github.com/rails/rails/issues/38279#issuecomment-609864754
                              # A solution for the issue is already merged but not yet released. An upcoming
                              # release might include a fix, so that `minitest` can be unlocked again.
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end
