ActiveRecord::Base.configurations = { 'vuash' => { adapter: 'sqlite3', database: "db/vuash.db" } }
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations["vuash"])
