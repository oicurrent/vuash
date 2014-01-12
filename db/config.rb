require 'uri'
require 'active_record'

database_url = ENV['DATABASE_URL'] || "sqlite3://localhost/db/vuash.sqlite3"

ActiveRecord::Base.establish_connection(database_url)
