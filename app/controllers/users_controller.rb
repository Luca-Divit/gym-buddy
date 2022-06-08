class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]


  def index
    users_all = User.all
    # user_filter = @users_all.where(partner_gender_preference: current_user.partner_gender_preference) ||
    #   @users_all.where(level_of_fitness: current_user.level_of_fitness)
    @users = common_activities2(users_all)
    raise
    # users = common_days(users_all)

    # @users = new_users.reject { |user| user == current_user }
  end

  private

  def common_days(users_all)
    days = []
    users_all.each do |user|
      unless (user.days_available & current_user.days_available).empty?
        days << user
      end
    end
    return days
  end

  def common_activities2(users)
    common_activities = []
    users.each do |user|
      unless (user.activities & current_user.activities).empty?
        common_activities << user
      end
    end
    return common_activities
  end

end
