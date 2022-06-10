class User < ApplicationRecord
  has_many :user_activities
  has_many :activities, through: :user_activities
  has_many_attached :photos
  accepts_nested_attributes_for :user_activities
  accepts_nested_attributes_for :activities
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
