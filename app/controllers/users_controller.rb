class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]

  def index
    @users = User.all
    @users = @users.where(partner_gender_preference: current_user.partner_gender_preference)
    # @users = User.all
    # prefereces.match just one sport or one day
    #@users = User.where(location, preferences)
  end



end
