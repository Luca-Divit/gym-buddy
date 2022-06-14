class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(recipient: current_user)
    @user = current_user
    mark_notification_as_read
    redirect_to homepage_users_path
  end

  private

  def mark_notification_as_read
    if current_user
      @user = current_user
      notifications_to_mark_as_read = @user.notifications.where(recipient: current_user)
      notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
    end
  end

end
