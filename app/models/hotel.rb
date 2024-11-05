# app/models/hotel.rb
class Hotel < ApplicationRecord

  has_many :rooms, dependent: :destroy
  has_and_belongs_to_many :amenities
  has_many :reservations

  has_many_attached :images


  validates :name, :location, :email, :total_rooms, :floors, :max_rooms_per_floor, :telephone,
            :address_street, :address_number, :address_neighborhood, :address_city,
            :address_state, :address_zip_code, :title, :description,  presence: true

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :total_rooms, :floors, :max_rooms_per_floor, numericality: { greater_than: 0 }
  validate :total_rooms_matches_floors_and_max_rooms_per_floor
  validate :must_have_at_least_one_amenity

  after_create :create_rooms

  def formatted_address
    [
      address_street.presence,  # Verifica se o valor está presente
      address_number.presence,
      address_city.presence,
      address_state.presence
    ].compact.join(", ").gsub(", #{address_state}", " - #{address_state}")
  end

  def self.ransack_attributes(*)
    ["name"]
  end

  private

  def total_rooms_matches_floors_and_max_rooms_per_floor
    if total_rooms.to_i > (floors.to_i * max_rooms_per_floor.to_i)
      errors.add(:total_rooms, "não pode exceder o produto de andares e quartos máximos por andar")
    end
  end

  def must_have_at_least_one_amenity
    if amenity_ids.empty?
      errors.add(:amenity_ids, "Selecione pelo menos uma amenity")
    end
  end

  def create_rooms
    room_count = 0
    (1..floors).each do |floor|
      (1..max_rooms_per_floor).each do |room_number|
        break if room_count >= total_rooms
        formatted_room_number = sprintf("%02d", room_number)
        full_room_number = "#{floor}#{formatted_room_number}"
        rooms.create(room_number: full_room_number, floor_number: floor, status: "available", room_type_id: 1)
        room_count += 1
      end
    end
  end
end
