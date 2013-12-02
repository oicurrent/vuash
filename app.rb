require 'sinatra'
require 'active_record'
require 'securerandom'

require_relative 'db/config'
require_relative 'models/message'

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

get '/:uuid' do
  if @message = Message.find_by(uuid: params['uuid'])
    @message.destroy
    haml :show
  else
    haml :removed
  end
end
