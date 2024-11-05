module Admin
  class RoomsController < BaseController

    before_action :load_hotel, only: [:index, :room_to_block]

    def index
      @rooms = @hotel.rooms.includes(:room_type).order(:floor_number, :room_number)
    end

    def room_to_block
      @rooms_to_block = Room.detailed_rooms_with_reservations_and_block_rooms(params[:hotel_id])
      @blockroom = BlockRoom.new
      @min_date = Date.today + 1
    end

    def create_block_room
      @blockroom = BlockRoom.new(block_room_params)
      @blockroom.status = "inprogress"
      if @blockroom.save
        redirect_to admin_hotels_path, notice: "Quarto bloqueado com sucesso !!!"
      else
        @rooms_to_block = Room.detailed_rooms_with_reservations_and_block_rooms(params[:hotel_id])
        @hotel = Hotel.find(params[:hotel_id])
        @min_date = Date.today + 1
        render "room_to_block", status: :unprocessable_entity
      end
    end



    def update_multiple
      params[:rooms][:rooms].each do |_index, room_params|
        room = Room.find(room_params[:id])
        room.update(room_params.permit(:room_type_id, :daily_price, :description, :status))
      end

      redirect_to admin_hotel_rooms_path, notice: 'Quartos atualizados com sucesso.'
    end

    private

    def load_hotel
      @hotel = Hotel.find(params[:hotel_id])
    end

    def block_room_params
      params.require(:block_room).permit(:room_id, :start_date, :end_date, :reason)
    end

    def rooms_params
      params.require(:hotel).permit(rooms: [:id, :room_type_id, :daily_price, :description, :status])
    end
  end
end
