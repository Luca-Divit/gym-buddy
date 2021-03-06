class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :show, :setting, :update, :homepage ]
  before_action :filtered_users, only: [ :index, :homepage, :map, :show, :map ]

  def index
  end

  def show
    @user = User.find(params[:id])
    @match_current_user = Match.find_by(user_requester_id: current_user.id, user_receiver_id: @user.id) || Match.find_by(user_requester_id: @user.id, user_receiver_id: current_user.id)
    @markers = [
      {
        lat: @user.latitude,
        lng: @user.longitude,
        info_window: render_to_string(partial: "info_window", locals: {user: @user}),
        image_url: helpers.asset_url("marker.png")
      },
      {
        lat: current_user.latitude,
        lng: current_user.longitude,
        info_window: render_to_string(partial: "info_window", locals: {user: current_user}),
        image_url: helpers.asset_url("marker.png")
      }
    ]
  end

  def map
    @markers = @users_matching.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window: render_to_string(partial: "info_window", locals: {user: user}),
        image_url: helpers.asset_url("marker.png")
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
      :age,
      days_available: [],
      photos: [],
      user_activities_attributes: [:activity_ids => []]
    )
  end

  def filtered_users
    # 1 - Setting the factbase
    users = User.all
    @users_matching = []

    #removes the current user from the sample so they do not show up on the index page
    users.each do |user|
      if (user != current_user)
        @users_matching << user
      end
    end


    #remove users that have I already have a match with
    match_users = []
    current_user.received_matches.each do |match|
      match_users << match.user_requester_id.to_i
    end


    current_user.requested_matches.each do |match|
      match_users << match.user_receiver_id.to_i
    end

    users_matching_a = []
      @users_matching.each do |user|
        if match_users.include?(user.id.to_i) == false
          users_matching_a << user
        end
      end
    @users_matching = users_matching_a

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
    if current_user.level_of_fitness != ""
      @users_matching_2 = []
      @users_matching.each do |user|
        if user.level_of_fitness == current_user.level_of_fitness
          @users_matching_2 << user
        end
      end
        @users_matching = @users_matching_2
    end


    # 4 - Filter by preffered gender
    @users_matching_3 = []
      if current_user.partner_gender_preference != "Any"
        @users_matching.each do |user|
        (user.gender == current_user.partner_gender_preference && (user.partner_gender_preference == current_user.gender || user.partner_gender_preference == "Any")) ? @users_matching_3 << user : nil
        end
      else
        @users_matching.each do |user|
        (user.partner_gender_preference == current_user.gender || user.partner_gender_preference == "Any") ? @users_matching_3 << user : nil
        end
      end
      @users_matching = @users_matching_3
    end
end
