#!/usr/bin/env rake

task :migrate do
  if File.exists? database
    puts 'Database already created'
  else
    require          'active_record'
    require_relative 'arbase'

    load 'db/schema.rb'
    puts 'Database succesfully created'
  end
end
