class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :hotel
  belongs_to :room
  has_one :payment
  belongs_to :cancellation_reason, optional: true
  belongs_to :canceled_by_user, class_name: 'User', optional: true

  enum status: { reserved: 'reserved', canceled: 'canceled', completed: 'completed' }

  attr_accessor :terms_accepted

  before_validation :calculate_total_daily

  before_create :generate_reservation_code

  validates :hotel_id, :user_id, :room_id, :check_in_date, :check_out_date, presence: true
  validates :daily_price, numericality: { greater_than: 0 }
  validates :total_daily, numericality: { greater_than: 0 }
  validates :check_in_date, :check_out_date, comparison: { greater_than_or_equal_to: -> { Date.today + 1 } }
  validates :check_out_date, comparison: { greater_than_or_equal_to: :check_in_date }

  validates :terms_accepted, presence: true, on: :cancellation

  validates :cancellation_reason, acceptance: true, on: :cancellation

  monetize :daily_price_cents
  monetize :total_daily_cents

  def self.available_cancellation_reasons
    CancellationReason.active_ordered
  end

  def cancel!(cancellation_reason_id:, cancellation_notes:, user_id:)
    update!(
      cancellation_reason_id: cancellation_reason_id,
      cancellation_notes: cancellation_notes,
      canceled_by_user_id: user_id,
      canceled_at: Time.current,
      status: "canceled"
      )
      room.update!(status: 'available')

      true
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  def generate_reservation_code
    self.reservation_code = SecureRandom.alphanumeric(15).upcase
  end

  def calculate_total_daily
    if check_in_date.present? && check_out_date.present? && room.present?
      self.daily_price = room.daily_price
      days = (check_out_date - check_in_date).to_i + 1
      self.total_daily = days * daily_price
    end
  end

end
