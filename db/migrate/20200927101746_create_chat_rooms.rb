class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.integer :recipient_id
      t.integer :sender_id

      t.timestamps
    end
    add_index :chat_rooms, :recipient_id
    add_index :chat_rooms, :sender_id
    add_index :chat_rooms, [:recipient_id, :sender_id], unique: true
  end
end
