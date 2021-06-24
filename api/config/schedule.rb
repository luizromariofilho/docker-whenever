# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
env :GEM_PATH, '/api/' # defines where to find rake command
set :output, '/var/log/cron.log' # log location

# We override rake job type, as we don't want envrinoment specific task
job_type :rake, 'cd :path && bundle exec rake :task --silent :output'

# runs every minute
every 1.minute do
  # this will log in cron.log as defined above.
  rake 'log_to_console'
end
