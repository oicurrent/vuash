require 'sequel'

ENV['RACK_ENV'] ||= 'development'

if ENV['RACK_ENV'] != 'production'
  require 'dotenv'
  Dotenv.load
end

# Delete DATABASE_URL from the environment, so it isn't accidently
# passed to subprocesses.  DATABASE_URL may contain passwords.
DB = Sequel.connect(ENV.delete('DATABASE_URL'))
