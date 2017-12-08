class MessagesController < ApplicationController
  protect_from_forgery except: :create

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
    respond_to do |format|
      format.html
      format.json { render json: @message.to_json(only: :id) }
    end
  end

  def show
    @message = Message.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render 'missing'
  end

  def destroy
    respond_to do |format|
      begin
        @message = Message.destroy(params[:id])
        format.html
        format.json { render json: @message.to_json(only: :data) }
      rescue ActiveRecord::RecordNotFound
        format.html { render 'missing' }
        format.json { render json: { error: 'Not found' } }
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:data)
  end
end
