Rails.application.routes.draw do
  get '/' => 'messages#new', as: 'messages'
  post '/' => 'messages#create'
  get '/:uuid' => 'messages#show', as: 'message'
  delete '/:uuid' => 'messages#destroy'
end
