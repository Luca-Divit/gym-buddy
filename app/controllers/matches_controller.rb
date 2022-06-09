class MatchesController < ApplicationController
  def index
    @all_matches = Match.all
    @my_gymbuddies = @all_matches.where(status: 1)
    @my_match_to_accept = Match.where(user_receiver_id: current_user.id)
    @my_match_to_accept_real = @my_match_to_accept.where(status: 0)
  end

  def create
    @match = Match.new
    @match.user_receiver_id = params[:user_receiver_id]
    @match.user_requester_id = params[:user_requester_id]
    @match.status = params[:status].to_i
    @match.save!
    redirect_to users_path
  end

  def update
    @match = Match.find(params[:id])
    @match.status = params[:status].to_i
    @match.save!
    redirect_back(fallback_location: root_path)
  end
end
