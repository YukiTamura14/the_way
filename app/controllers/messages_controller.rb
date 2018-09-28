class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

 def index
   @messages = @conversation.messages
   redirect_if_not_correct_messenger
   if @messages.length > 10
     @over_ten = true
     @messages = @messages[-10..-1]
   end

   if params[:m]
     @over_ten = false
     @messages = @conversation.messages
   end

   if @messages.last && @messages.last.user_id != current_user.id
      @messages.last.read = true
   end
     @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      flash[:danger] = "メッセージを入力してください"
      redirect_to  conversation_messages_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def redirect_if_not_correct_messenger
    redirect_to concerns_path(@concern) unless @conversation.sender_id == current_user.id || @conversation.recipient_id == current_user.id
  end

end
