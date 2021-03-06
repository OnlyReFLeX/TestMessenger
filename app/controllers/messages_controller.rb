class MessagesController < ApplicationController
  before_action :find_conversation

  def index
    if current_user.id == @conversation.sender_id || current_user.id == @conversation.recipient_id
      @messages = @conversation.messages
      if @messages.length > 10
        @over_ten = true
        @messages = @messages[-10..-1]
      end
      if params[:m]
        @over_ten = false
        @messages = @conversation.messages
      end
      if @messages.last
        if @messages.last.user_id != current_user.id
          @messages.last.read = true;
        end
      end
      @message = @conversation.messages.new
    else
      redirect_to root_path
      flash[:alert] = "Не в тот раздел зашел )))"
    end
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user_id = @current_user.id
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

private
  def find_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
  def message_params
    params.require(:message).permit(:body)
  end
end
