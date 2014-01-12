require 'active_record'

DATABASE_URL = ENV['DATABASE_URL'] || "sqlite3://localhost/db/vuash.sqlite3"
ActiveRecord::Base.establish_connection DATABASE_URL

require_relative 'models/message'
