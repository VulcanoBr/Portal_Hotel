class Room < ApplicationRecord

  belongs_to :hotel
  belongs_to :room_type
  has_many :reservations
  has_many :block_rooms

  enum status: { available: 'available', reserved: 'reserved', maintenance: 'maintenance',
                  disabled:'disabled', unavailable: "unavailable" }

  validates :room_number, :floor_number, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: ['available', 'occupied', 'reserved', 'maintenance', "disabled", "unavailable"] }

  monetize :daily_price_cents

  def self.available_between(hotel_id, check_in_date, check_out_date)
    where(hotel_id: hotel_id, status: 'available')
      .where.not(
        id: left_outer_joins(:reservations)
            .where("(reservations.check_in_date, reservations.check_out_date) OVERLAPS (?, ?)", check_in_date, check_out_date)
            .where(reservations: { status: 'reserved' })
      )
      .where.not(
        id: left_outer_joins(:block_rooms)
            .where("(block_rooms.start_date, block_rooms.end_date) OVERLAPS (?, ?)", check_in_date, check_out_date)
            .where(block_rooms: { status: 'inprogress' })
      )
      .order(:floor_number, :room_number)
  end

  scope :with_reservations_and_block_rooms, ->(hotel_id) {
    includes(:reservations, :block_rooms)
      .where(hotel_id: hotel_id)
  }

  def self.detailed_rooms_with_reservations_and_block_rooms(hotel_id)
    with_reservations_and_block_rooms(hotel_id).map do |room|
      {
        room: room,
        reservations: room.reservations.where(status: 'reserved').map { |res| { check_in_date: res.check_in_date, check_out_date: res.check_out_date } },
        block_rooms: room.block_rooms.where(status: 'inprogress').map { |block| { start_date: block.start_date, end_date: block.end_date, reason: block.reason } }
      }
    end
  end

end
