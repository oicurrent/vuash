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
  @message.encrypt
  @message.save!

  haml :preview
end

get '/:uuid' do
  @message = Message.find_by(uuid: params['uuid'])

  if @message
    if params['secret']
      @message.destroy
      @message.decrypt(params['secret'])

      haml :show
    else
      haml :secret
    end
  else
    haml :removed
  end
end
