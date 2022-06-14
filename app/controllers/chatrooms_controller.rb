class ChatroomsController < ApplicationController

  def show
    #need to get the match params id
    @match = Match.find(params[:match_id])
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def create
    @skip_footer = true
    @match = Match.find(params[:match_id])
    @chatroom = Chatroom.new
    @chatroom.match = @match
    if @chatroom.save
      redirect_to user_match_chatroom_path(current_user, @match, @chatroom)
    else
      raise
    end
  end

  def chat_params
    params.require(:chatroom).permit(:name)
  end

end
