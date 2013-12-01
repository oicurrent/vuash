#!/usr/bin/env rake

task :migrate do
  database = 'db/vuash.db'

  if File.exists? database
    puts 'Database already created'
  else
    require 'active_record'
    ActiveRecord::Base.configurations = { 'vuash' => { adapter: 'sqlite3', database: database } }
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations["vuash"])

    load 'db/schema.rb'

    puts 'Database succesfully created'
  end
end
