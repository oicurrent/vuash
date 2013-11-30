#!/usr/bin/env rake

task :migrate do
  if File.exists? 'memory.db'
    puts 'Database already created'
  else
    require 'active_record'
    ActiveRecord::Base.configurations = { 'memory' => { adapter: 'sqlite3', database: "memory.db" } }
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations["memory"])

    load 'schema.rb'

    puts 'Database succesfully created'
  end
end
