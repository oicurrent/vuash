require 'sinatra'
require 'active_record'
require 'securerandom'
require 'newrelic_rpm'

require_relative 'db/config'
require_relative 'models/message'

get '/' do
  haml :index
end

post '/' do
  data = params['body']
  return if data.empty?
  @message = Message.new body: data
  @message.encrypt
  @message.save!

  haml :preview, layout: false
end

get '/:uuid' do
  uuid = params['uuid'][0..15]
  secret = params['uuid'][16..32]

  @message = Message.find_by(uuid: uuid)

  if @message
    @message.destroy
    @message.decrypt(secret)

    haml :show
  else
    haml :removed
  end
end

get '/public/stylesheets/sass/:name.sass' do |name|
  require './public/stylesheets/sass/bourbon/lib/bourbon.rb'
  content_type :css
  sass name.to_sym, layout: false
end

after do
  ActiveRecord::Base.clear_active_connections!
end
