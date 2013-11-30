require 'sinatra'
require 'active_record'
require 'securerandom'

ActiveRecord::Base.configurations = { 'memory' => { adapter: 'sqlite3', database: "memory.db" } }
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations["memory"])

# Essa linha deve ser descomentada na primeira vez que o scrip rodar
# Apos isso ela deve ser comentada, pq o active record ja tera criada a tabela
# TODO: Fix it
# load 'schema.rb'

class Message < ActiveRecord::Base
end

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

@@ preview
%h1
  Mensagem criada com sucesso!

%br
= @message.info
%br
Link:
%a(href="http://localhost:9393/messages/#{@message.uuid}")
  http://localhost:9393/messages/#{@message.uuid}

%br
%a(href="/")
  Voltar

@@ show
%h1
  Essa mensagem se auto-destruiu

%br
= @info

%br
%a(href="/")
  Voltar

@@ removed
%h1
  Mensagem removida

%br
%a(href="/")
  Voltar
