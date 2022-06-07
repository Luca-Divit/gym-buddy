class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @users = User.all
    # prefereces.match just one sport or one day
    #@users = User.where(location, preferences)
  end
end
