module MessagesHelper
   def index
     @conversation = Conversation.find(params[:conversation_id])
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
        @messages.last.read = true
       end
     end
     @message = @conversation.messages.build
   end

end
