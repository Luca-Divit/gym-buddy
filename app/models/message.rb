class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  has_noticed_notifications
  after_create_commit :notify_user

  def notify_user
    MessageNotification.with(message: self).deliver_later(user)
  end
end
