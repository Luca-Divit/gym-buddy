class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :show, :setting, :update, :homepage ]
  before_action :filtered_users, only: [ :index, :homepage, :map, :show, :map ]

  def index
  end

  def show
    @user = User.find(params[:id])
    @markers = [
      {
        lat: @user.latitude,
        lng: @user.longitude
      },
      {
        lat: current_user.latitude,
        lng: current_user.longitude
      }
    ]
  end

  def map
    @markers = @users_matching.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude
      }
    end
  end

  def setting
  end

  def update
    @user = current_user
    UserActivity.where(user: @user).each { |activity| UserActivity.destroy(activity.id) }
    if params["user"]["activity_ids"]
      params["user"]["activity_ids"].shift
      params["user"]["activity_ids"].each do |id|
        if Activity.find(id.to_i)
          @user.activities << Activity.find(id.to_i)
        end
      end
    else
      @user.update(user_params)
    end
    redirect_to setting_user_path(@user)
  end

  def homepage
    @all_matches = Match.all
    @my_gymbuddies = @all_matches.where(status: 1)
    @my_match_to_accept = Match.where(user_receiver_id: current_user.id)
    @my_match_to_accept_real = @my_match_to_accept.where(status: 0)
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :gender,
      :address,
      :partner_gender_preference,
      :level_of_fitness,
      :bio,
      days_available: [],
      photos: [],
      user_activities_attributes: [:activity_ids => []]
    )
  end

  def filtered_users
    # 1 - Setting the factbase
    @users = User.all
    @users_matching = []

    #removes the current user from the sample so they do not show up on the index page
    @users.each do |user|
      if (user != current_user)
        @users_matching << user
      end
    end
    #remove users that have already sent me a request
    current_user.received_matches.each do |user|
      @users_matching.delete(user)
    end

    #remove users that I have already sent a request
    current_user.requested_matches.each do |user|
      @users_matching.delete(user)
    end

    # 2 - Filter by activity if parameter provided by user
    current_user_activities_name = [] # get the activities of the current user if they exists
    current_user.activities.each do |activity|
      current_user_activities_name << activity.name
    end

    unless current_user_activities_name.empty?
      @users_matching_1 = []
      @users_matching.each do |user|
        user_activities_name = []
        user.activities.each do |activity|
          user_activities_name << activity.name
        end
        if user_activities_name.any? {|activity| current_user_activities_name.include?(activity)}
          @users_matching_1 << user
        end
      end
      @users_matching = @users_matching_1
    end

    # 3 - Filter by fitness level if paramter provided by user
    unless current_user.level_of_fitness.nil?
      @users_matching_2 = []
      @users_matching.each do |user|
        if user.level_of_fitness == current_user.level_of_fitness
          @users_matching_2 << user
        end
      end
      @users_matching = @users_matching_2
    end

    # 4 - Filter by preffered gender
    if current_user.partner_gender_preference != "Flexible"
      @users_matching_3 = []
      @users_matching.each do |user|
        unless user.gender.nil?
          @users_matching_3 << user if current_user.partner_gender_preference.downcase == user.gender.downcase
        end
      end
      @users_matching = @users_matching_3
    end
  end
end
