class Hotel < ApplicationRecord
    belongs_to :user
    mount_uploader :image, ImageUploader
    has_many :reservations, dependent: :destroy
    validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :address, presence: true
end
