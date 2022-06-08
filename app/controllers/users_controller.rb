class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]

  def index
    @users = User.all
    # prefereces.match just one sport or one day
    #@users = User.where(location, preferences)
  end

  def show
    @user = User.find(params[:id])
    @match = Match.new
    @match.user_receiver_id = @user.id
    @match.user_requester_id = current_user.id
    @match.save!
  end
end
