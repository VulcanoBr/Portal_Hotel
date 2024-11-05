module Hotels
  class GetRoomPriceDescription
    def self.call(hotels)
      first_room_details = {}

      hotels.includes(rooms: :room_type).each do |hotel|
        first_room = hotel.rooms.first
        if first_room
          room_type_description = first_room.room_type.description
          first_room_details[hotel.id] = {
            daily_price: first_room.daily_price,
            room_type_description: room_type_description
          }
        end
      end
      first_room_details
    end
  end
end
