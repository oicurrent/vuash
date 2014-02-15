# define paths and filenames
timeout 30
worker_processes 2 # increase or decrease

pid '/tmp/unicorn.pid'
stderr_path './log/unicorn_error.log'
stdout_path './log/unicorn.log'

# make forks faster
preload_app true

# make sure that Bundler finds the Gemfile
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
end

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end
