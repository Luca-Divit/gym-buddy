class Match < ApplicationRecord
  enum status: {
    pending: 0,
    accepted: 1,
    declined: 2
  }

  belongs_to :user_requester, class_name: 'User'
  belongs_to :user_receiver, class_name: 'User'
end
