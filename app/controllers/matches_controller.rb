class MatchesController < ApplicationController

  def index
    confirmed_matches = Match.all.where(status: 1)
    requested_confirmed_matches = confirmed_matches.where(user_requester_id: current_user.id)
    received_confirmed_matches = confirmed_matches.where(user_receiver_id: current_user.id)
    @my_gymbuddies = requested_confirmed_matches + received_confirmed_matches
    @my_match_to_accept = Match.where(user_receiver_id: current_user.id)
    @my_match_to_accept_real = @my_match_to_accept.where(status: 0)
    @chatroom = Chatroom.new
  end

  def create
    @match = Match.new
    @match.user_receiver_id = params[:user_receiver_id]
    @match.user_requester_id = params[:user_requester_id]
    CommentNotification.with(message: "You recieved a match request from  #{User.find(@match.user_requester_id).first_name}").deliver(User.find(@match.user_receiver_id))
    @match.status = params[:status].to_i
    @match.save!
    sleep(3)
    redirect_to homepage_users_path
  end

  def update
    @match = Match.find(params[:id])
    @match.status = params[:status].to_i
    @match.save!
    if @match.status == 1
      #the other guy accepted your request
      @chatroom = Chatroom.create(match_id: @match.id, name: @match.user_receiver.first_name)
    end
    CommentNotification.with(message: "Your match request was accepted by   #{User.find(@match.user_receiver_id).first_name}").deliver(User.find(@match.user_requester_id))
    redirect_back(fallback_location: root_path)
  end
end
