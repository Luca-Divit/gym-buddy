class Match < ApplicationRecord
  enum status: {
    pending: 0,
    accepted: 1,
    declined: 2
  }

  belongs_to :user_requester, class_name: "User", foreign_key: 'user_requester'
  belongs_to :user_receiver, class_name: "User", foreign_key: 'user_receiver'
end
