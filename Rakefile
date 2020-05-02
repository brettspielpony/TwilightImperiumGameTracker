# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

# We only use Rubocop in Development and Test, not
# in Production. Therefore we only inject it to the default
# task, if we can.
begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    # task.requires << "rubocop-rails"
    task.options = %w[--parallel]
  end
rescue LoadError # rubocop:disable Lint/SuppressedException
end

Rails.application.load_tasks
