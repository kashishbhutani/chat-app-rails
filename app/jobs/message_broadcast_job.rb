class MessageBroadcastJob < ApplicationJob
  # Queue Type
  queue_as :default

  def perform(message)
    sender = message.user
    recipient = message.chat_room.opposed_user(sender)

    broadcast_to_sender(sender, message)
    broadcast_to_recipient(recipient, message)
  end

  private

  def broadcast_to_sender(user, message)
    ActionCable.server.broadcast(
      "chatrooms-#{user.id}",
      message: render_message(message, user),
      chat_room_id: message.chat_room_id
    )
  end

  def broadcast_to_recipient(user, message)
    ActionCable.server.broadcast(
      "chatrooms-#{user.id}",
      window: render_window(message.chat_room, user),
      message: render_message(message, user),
      chat_room_id: message.chat_room_id
    )
  end

  def render_message(message, user)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
  end

  def render_window(chat_room, user)
    ApplicationController.render(
      partial: 'chat_rooms/chat_room',
      locals: { chat_room: chat_room, user: user }
    )
  end
end
