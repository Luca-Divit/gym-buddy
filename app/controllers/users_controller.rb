class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]

  def index
    users = User.all
    @users_matching = User.all

    # 1 - get current user data
    user1 = current_user
    address = user1.address #get the adress of the current user

    current_user_activities_name = [] # get the activities of the current user if they exists
    user1.activities.each do |activity|
      current_user_activities_name << activity.name
    end

    # 2 - Filter by activity if parameter provided by user
    if current_user_activities_name.empty? == false
      @users_matching_1 = []
      users.each do |user|
        user_activities_name = []
        user.activities.each do |activity|
          user_activities_name << activity.name
        end
        if user_activities_name.any? {|activity| current_user_activities_name.include?(activity) }
          @users_matching_1 << user
        end
      end
      @users_matching = @users_matching_1
    end

    # 3 - Filter by fitness level if paramter provided by user
    if user1.level_of_fitness != nil
      @users_matching_2 = []
      @users_matching.each do |user|
        if (user.level_of_fitness == user1.level_of_fitness)
          @users_matching_2 << user
        end
      end
      @users_matching = @users_matching_2
    end

    # 4 - Filter by preffered gender
   if user1.partner_gender_preference != nil
      @users_matching_3 = []
      @users_matching.each do |user|
        user.gender == user1.partner_gender_preference ? @users_matching_3 << user : nil
      end
      @users_matching = @users_matching_3
    end

  end

  def show
    @user = User.find(params[:id])
    @match = Match.new
    @match.user_receiver_id = @user.id
    @match.user_requester_id = current_user.id
    @match.save!
  end
end
