
class ReservationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :user_id, :hotel_id, :room_id, :check_in_date, :check_out_date, :daily_price

  validates :hotel_id, :room_id, :check_in_date, :check_out_date, presence: true
  validate :check_in_date_before_check_out_date

  def hotel
    @hotel ||= Hotel.find_by(id: hotel_id) if hotel_id.present?
  end

  def check_in_date_before_check_out_date
    if check_in_date.present? && check_out_date.present? && check_in_date > check_out_date
      errors.add(:check_in_date, "deve ser anterior à data de término")
    end
  end


end
