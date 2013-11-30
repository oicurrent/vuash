require 'sinatra'
require 'active_record'
require 'securerandom'

ActiveRecord::Base.configurations = { 'memory' => { adapter: 'sqlite3', database: ":memory:" } }
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations["memory"])

load 'schema.rb'

class Message < ActiveRecord::Base
end

get '/' do
  haml :index
end

post '/' do
  @message = Message.new(info: params['info'], uuid: SecureRandom.hex)

  if @message.save
    haml :show
  else
    'Something goes wrong'
  end
end


__END__

@@layout
%html
  %title Vuash

  %div
    = yield

@@ index
%form(action = '/' method = 'post')
  %textarea(name = 'info')
  %br
  %input(type= 'submit' value='Enviar')

@@ show
%div
  %h1
    Mensagem criada com sucesso!

  %br
  = @message.info
  %br
  Link:
  %a(href="http://localhost:9393/messages/#{@message.uuid}")
    http://localhost:9393/messages/#{@message.uuid}
