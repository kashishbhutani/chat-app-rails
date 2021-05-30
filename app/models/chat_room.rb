class ChatRoom < ApplicationRecord
  # Associatons
  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  # Validations
  validates :sender_id, uniqueness: { scope: :recipient_id }

  # Scopes
  scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  # Class Method
  def self.get(sender_id, recipient_id)
    chat_room = between(sender_id, recipient_id).first

    return chat_room if chat_room.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  # Instance Method
  def opposed_user(user)
    user == recipient ? sender : recipient
  end
end
