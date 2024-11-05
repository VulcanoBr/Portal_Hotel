module Hotels
  class RoomTypesFetcher

    def self.fetch(hotel)
      hotel.rooms.joins(:room_type).distinct.pluck(:room_type_id, 'room_types.description')
    end
  end
end
