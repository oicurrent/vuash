require 'sinatra'
require 'rack/cache'
require 'newrelic_rpm'
require_relative 'boot'

module Vuash
  class Application < Sinatra::Base
    use Rack::Cache

    configure do
      disable :sessions
    end

    helpers do
      include Rack::Utils
      alias_method :h, :escape_html
    end

    before do
      cache_control :public, :max_age => 36000
    end

    after do
      ActiveRecord::Base.clear_active_connections!
    end

    get '/' do
      haml :index
    end

    get '/cached' do
      sleep 5
      "cache it!"
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
      haml :before_show
    end

    post '/:uuid' do
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

  end
end
