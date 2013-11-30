require 'sinatra'
require 'active_record'

ActiveRecord::Base.configurations = { 'memory' => { adapter: 'sqlite3', database: ":memory:" } }
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations["memory"])

load 'schema.rb'

class Message < ActiveRecord::Base
end

get '/' do
  haml :index
end

post '/' do
  @message = Message.new(info: params['info'])
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
  = yield

@@ index
%form(action = '/' method = 'post')
  %textarea(name = 'info')
  %input(type= 'submit' value='Enviar')

@@ show
%div
  Mensagem criada com sucesso!
  = @message.info
