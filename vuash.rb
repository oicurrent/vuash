require 'roda'
require 'sequel'
require 'bourbon'
require 'neat'
require 'sequel'

require_relative 'boot'

class Message < Sequel::Model
  plugin :validation_helpers
  plugin :uuid, field: :id

  MAX = 16416

  def validate
    super
    validates_length_range 1..MAX, :data
  end
end

class Vuash < Roda
  use Rack::Session::Cookie, :secret => ENV['SECRET']

  plugin :assets, :css => 'application.sass', :js => 'application.coffee'
  plugin :render, engine: "haml"
  plugin :i18n
  plugin :json
  plugin :public
  plugin :csrf, :raise => true

  route do |r|
    r.public
    r.assets
    r.i18n_set_locale_from(:http)

    r.root do
      view 'new'
    end

    r.post "" do
      if message = Message.create(data: r['message_data'])
        { ok: true, uuid: message.id }
      else
        { ok: false, uuid: nil }
      end
    end

    r.on ':uuid' do |uuid|
      @message = Message[uuid]

      r.get do
        if @message
          view 'show'
        else
          view 'missing'
        end
      end

      r.post do
        @message.delete
        { ok: true, message: @message.data }
      end
    end
  end
end
