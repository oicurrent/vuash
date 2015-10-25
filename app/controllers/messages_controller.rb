class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
  end

  def show
    @message = Message.find_by(uuid: params[:uuid])
    render 'missing' unless @message
  end

  def destroy
    if @message = Message.find_by(uuid: params[:uuid])
      @message.destroy
    else
      render 'missing'
    end
  end

  private
  def message_params
    params.require(:message).permit(:data)
  end
end
