class User < ApplicationRecord
       has_many :hotels
       devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable
       mount_uploader :profile_image, ProfileImageUploader
       has_many :reservations
     
       validates :name, presence: true
     end
     
