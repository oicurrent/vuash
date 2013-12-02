require 'sinatra'
require 'active_record'
require 'securerandom'

require_relative 'db/config'
require_relative 'models/message'

get '/' do
  haml :index
end

post '/' do
  @message = Message.new body: params['body']
  @message.encrypt(params['secret'])
  @message.save!

  haml :preview
end

get '/messages/:uuid' do
  @message = Message.find_by(uuid: params['uuid'])

  if @message
    @message.destroy
    @message.decrypt(params['secret'])
    haml :show
  else
    haml :removed
  end
end
