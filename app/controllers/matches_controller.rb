class MatchesController < ApplicationController
  # def create
  #   @match = Match.new
  #   @user_receiver = User.find(params[:id])
  #   @match.user_receiver_id = @user_receiver.id
  #   @match.user_requester_id = current_user.id
  #   @match.save!
  #   redirect_to '/', status: :see_others
  # end

  def create
    @match = Match.new
    @match.user_receiver_id = params[:user_receiver_id]
    @match.user_requester_id = params[:user_requester_id]
    @match.status = params[:status].to_i
    @match.save!
    redirect_to users_path
  end

  # def update
  #   redirect_to users_path
  # end


end
