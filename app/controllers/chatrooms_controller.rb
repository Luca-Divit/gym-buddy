class ChatroomsController < ApplicationController

  def show
    #need to get the match params id
    @chatroom = Chatroom.find(params[:id])
  end

end
