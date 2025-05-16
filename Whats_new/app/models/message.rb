class Message < ApplicationRecord
    belongs_to :chat
    belongs_to :user
    validates :body, presence: true
    validate  :user_must_belong_to_chat
private
  def user_must_belong_to_chat
    chat_user_ids = [chat.sender_id, chat.receiver_id]

    unless chat_user_ids.include?(user_id)
      errors.add(
        :user_id,
        "the id must be of a user on the chat (sender o receiver)"
      )
    end
  end
end