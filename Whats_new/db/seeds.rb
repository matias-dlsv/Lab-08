require 'set'

Message.destroy_all
Chat.destroy_all
User.destroy_all


users = []
10.times do |i|
  users << User.create!(
    email: "user#{i + 1}@example.com",
    first_name: "First#{i + 1}",
    last_name: "Last#{i + 1}",
  )
end

puts "Created #{User.count} users"

# Crear chats únicos entre pares de usuarios
created_pairs = Set.new
chats = []

10.times do
  sender, receiver = users.sample(2)
  pair_key = [sender.id, receiver.id].sort

  next if sender.id == receiver.id || created_pairs.include?(pair_key)

  chats << Chat.create!(
    sender_id: sender.id,
    receiver_id: receiver.id
  )
  created_pairs.add(pair_key)
end

puts "Created #{Chat.count} chats"

chats.each do |chat|
  participants = [chat.sender_id, chat.receiver_id]
  5.times do |i|
    user_id = participants.sample
    Message.create!(
      chat_id: chat.id,
      user_id: user_id,
      body: "Mensaje #{i + 1} del usuario #{user_id} en chat #{chat.id}"
    )
  end
end

puts "Created #{Message.count} messages"
