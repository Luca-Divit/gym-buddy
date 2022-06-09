class MatchesController < ApplicationController
  def index
    @my_match_accepted = Match.where(user_requester_id: current_user.id)
    @my_match_to_accept = Match.where(user_receiver_id: current_user.id)
  end

  def create
    @match = Match.new
    @match.user_receiver_id = params[:user_receiver_id]
    @match.user_requester_id = params[:user_requester_id]
    @match.status = params[:status].to_i
    @match.save!
    redirect_to users_path
  end

end
