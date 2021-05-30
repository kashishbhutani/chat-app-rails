class Message < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :chat_room

  # Callbacks
  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
