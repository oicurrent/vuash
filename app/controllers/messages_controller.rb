class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
  end

  def show
    @message = Message.find_by(uuid: params[:uuid])
  end

  def destroy
    @message = Message.find_by!(uuid: params[:uuid]).destroy
  end

  private
  def message_params
    params.require(:message).permit(:data)
  end
end
