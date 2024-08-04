class Hotel < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :address, presence: true

  # スコープを追加
  scope :search_by_area, -> (area) { where('address LIKE ?', "%#{area}%") }
  scope :search_by_keyword, -> (keyword) { where('name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%") }
end
