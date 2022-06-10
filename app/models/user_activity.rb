class UserActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :user
  accepts_nested_attributes_for :activity, reject_if: :all_blank
end
