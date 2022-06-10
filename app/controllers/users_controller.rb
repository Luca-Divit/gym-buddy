class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]

  def index
    # 1 - Setting the factbase
    @users = User.all
    @users_matching = []
    user1 = current_user

    #removes the current user from the sample so they do not show up on the index page
    @users.each do |user|
      if (user != user1)
        @users_matching << user
      end
    end

    #remove users that have already sent me a request
    user1.received_matches.each do |user|
      @users_matching.delete(user)
    end

    #remove users that I have already sent a request
    user1.requested_matches.each do |user|
      @users_matching.delete(user)
    end


    # 2 - Filter by activity if parameter provided by user
    current_user_activities_name = [] # get the activities of the current user if they exists
    user1.activities.each do |activity|
      current_user_activities_name << activity.name
    end

    if current_user_activities_name.empty? == false
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
        (user.gender == user1.partner_gender_preference && user1.gender == user.partner_gender_preference)? @users_matching_3 << user : nil
      end
      @users_matching = @users_matching_3
    end

  end

  def show
    @user = User.find(params[:id])
  end

  def setting
  end
end
