class User < ApplicationRecord
  # Devise Modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Associations
  has_many :messages
  has_many :chat_rooms, foreign_key: :sender_id

  # Instance Method
  def name
    email.split('@')[0]
  end
end
