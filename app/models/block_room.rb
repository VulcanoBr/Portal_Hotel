class BlockRoom < ApplicationRecord

  belongs_to :room

  enum reason: { maintenance: 'maintenance', disabled:'disabled', unavailable: "unavailable" }

  enum status: { inprogress: "inprogress", finished: "finished" }

  validates :room_id, :start_date, :end_date, :reason, presence: true

  validates :start_date, :end_date, comparison: { greater_than_or_equal_to: -> { Date.today + 1 } }
  validates :end_date, comparison: { greater_than_or_equal_to: :start_date }

  validate :no_conflicting_reservations_or_blocks

  private

  def no_conflicting_reservations_or_blocks
    return unless start_date && end_date && room_id

    conflicting_reservations = Reservation.where(room_id: room_id)
                                          .where("status = 'reserved' AND ((check_in_date <= ? AND check_out_date >= ?) OR (check_in_date <= ? AND check_out_date >= ?))", end_date, start_date, start_date, end_date)

    conflicting_blocks = BlockRoom.where(room_id: room_id)
                                  .where("status = 'inprogress' AND ((start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?))", end_date, start_date, start_date, end_date)

    if conflicting_reservations.exists? || conflicting_blocks.exists?
      errors.add(:base, "Já existe uma reserva ou bloqueio para o quarto selecionado no período escolhido !!.")
    end
  end


end
