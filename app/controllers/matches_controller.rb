class MatchesController < ApplicationController
  def create
    @match = Match.new
    @user_receiver = User.find(params[:id])
    @match.user_receiver_id = @user_receiver.id
    @match.user_requester_id = current_user.id
    @match.save!
    redirect_to '/', status: :see_others
  end

  def update
    @users = User.all

    redirect_to root_path
  end
end
