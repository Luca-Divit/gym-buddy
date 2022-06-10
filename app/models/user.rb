class User < ApplicationRecord
  has_many :user_activities
  has_many :activities, through: :user_activities
  has_many_attached :photos
  accepts_nested_attributes_for :user_activities
  accepts_nested_attributes_for :activities
  has_many :requested_matches, class_name: "Match", foreign_key:"user_requester_id"
  has_many :received_matches, class_name: "Match", foreign_key:"user_receiver_id"
  has_many :matches

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
