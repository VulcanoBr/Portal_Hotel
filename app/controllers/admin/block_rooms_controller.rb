module Admin
  class BlockRoomsController < BaseController

    include Pagy::Backend

    def block_room_list
      @pagy, @blockrooms = pagy(BlockRoom.includes(room: [:hotel, :room_type])
                              .order(:start_date), limit: 6)
    end

    def finish
      @blockroom = BlockRoom.find(params[:id])
      if @blockroom.end_date < Date.current
        @blockroom.update(status: 'finished', finished_at: Time.current)
        redirect_to block_room_list_admin_block_rooms_path, notice: "Bloqueio finalizado com sucesso!"
      else
        redirect_to block_room_list_admin_block_rooms_path, alert: "Não é possível finalizar o bloqueio antes da data de término."
      end
    end

  end
end
