class Chat < ApplicationRecord
    has_many :messages
    belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
    belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
    validates :sender_id, presence: true
    validates :receiver_id, presence: true
    validate :sender_and_receiver_are_different
    
    scope :for_user, ->(user) {
    where(sender_id: user.id).or(where(receiver_id: user.id))
    }

    def other_participant(current_user)
        sender == current_user ? receiver : sender
    end
    private

    def sender_and_receiver_are_different
        if sender_id == receiver_id
        errors.add(:receiver_id, "must be different from sender")
        end
    end

    
end
