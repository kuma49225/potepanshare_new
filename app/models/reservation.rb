class Reservation < ApplicationRecord
  belongs_to :hotel
  belongs_to :user

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :number_of_people, numericality: { greater_than_or_equal_to: 1, message: :greater_than_or_equal_to }

  validate :check_in_cannot_be_in_the_past
  validate :check_out_must_be_after_check_in

  private

  def check_in_cannot_be_in_the_past
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, :check_in_cannot_be_in_the_past)
    end
  end

  def check_out_must_be_after_check_in
    if check_in.present? && check_out.present? && check_out <= check_in
      errors.add(:check_out, :check_out_must_be_after_check_in)
    end
  end
end
