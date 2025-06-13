class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chats = Chat.for_user(current_user)
                 .includes(:sender, :receiver)
                 .order(updated_at: :desc)
  end

  def show
    @chat = Chat.find(params[:id])
    authorize! :read, @chat    
    @sender = @chat.sender
    @receiver = @chat.receiver                
    @messages = @chat.messages.order(created_at: :asc)
  end

  def new
    @chat = Chat.new
  end
    
  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to chats_path, notice: "Chat created successfully."
    else
      render :new
    end
  end

  def edit
    @chat = Chat.find(params[:id])
  end

  def update
    @chat = Chat.find(params[:id])
    if @chat.update(chat_params)
      redirect_to @chat, notice: "Chat updated successfully."
    else
      render :edit
    end
  end
  

private
def chat_params
  params.require(:chat).permit(:sender_id, :receiver_id)
end

end