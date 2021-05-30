# frozen_string_literal: true

# Chat Rooms Controller Class
class ChatRoomsController < ApplicationController
  # Filters
  before_action :set_chat_room, only: [:close]

  # POST /chat_rooms/:id/create
  def create
    @chat_room = ChatRoom.get(current_user.id, params[:user_id])

    add_to_chat_rooms unless conversated?

    respond_to do |format|
      format.js
    end
  end

  # POST /chat_rooms/:id/close
  def close
    session[:chat_rooms].delete(@chat_room.id)

    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_chat_rooms
    session[:chat_rooms] ||= []
    session[:chat_rooms] << @chat_room.id
  end

  def conversated?
    session[:chat_rooms].include?(@chat_room.id)
  end

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end
end
