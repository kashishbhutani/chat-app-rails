# frozen_string_literal: true

# Messages Controller Class
class MessagesController < ApplicationController
  def create
    @chat_room = ChatRoom.includes(:recipient).find(params[:chat_room_id])
    @message = @chat_room.messages.create(message_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end
