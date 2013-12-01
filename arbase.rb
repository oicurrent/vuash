require 'uri'

configuration = {}

uri = URI.parse ENV['DATABASE_URL'] || "sqlite3:///db/vuash.sqlite3"

options = {}

(uri.query || "").split("&").each do |param|
  key, value = param.split("=")
  options[key.intern] = value
end

configuration = {
  adapter: uri.scheme,
  database: File.join(".", uri.path),
  host: uri.host,
  user: uri.user,
  password: uri.password
}

configuration.merge! options

ActiveRecord::Base.establish_connection(configuration)
