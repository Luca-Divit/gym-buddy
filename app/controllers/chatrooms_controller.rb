class ChatroomsController < ApplicationController


  # def create
  #   matches = Match.all
  #   matches.each do |match|
  #     if match.status == "accepted"
  #       Chatroom.create(match_id: @match.id, name: @match.user_receiver.first_name)
  #     end
  #   end
  # end

  def index
  @chatrooms = Chatroom.all
  end

  def show
    @chatroom = Chatroom.find(params[:id])
  end

end
