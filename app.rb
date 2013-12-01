require 'sinatra'
require 'active_record'
require 'securerandom'

require_relative 'models/message'

ActiveRecord::Base.configurations = { 'vuash' => { adapter: 'sqlite3', database: "db/vuash.db" } }
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations["vuash"])


get '/' do
  haml :index
end

post '/' do
  @message = Message.new(info: params['info'], uuid: SecureRandom.hex)

  if @message.save
    haml :preview
  else
    'Something goes wrong'
  end
end

get '/messages/:uuid' do
  message = Message.find_by(uuid: params['uuid'])
  if message
    @info = message.info
    message.destroy
    haml :show
  else
    haml :removed
  end
end
