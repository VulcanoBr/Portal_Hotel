module Admin
  class RoomTypesController < BaseController

    include Pagy::Backend

    before_action :load_room_type, only:  [ :show, :edit, :update, :destroy ]

    def index
      @pagy, @room_types = pagy(RoomType.order(:description), limit: 6)
    end

    def new
      @room_type = RoomType.new
    end

    def show; end

    def edit; end

    def create
      @room_type = RoomType.new(room_type_params)
      if @room_type.save
        redirect_to admin_room_types_path, notice: "room_type successfully created"
      else
        render 'new', status: :unprocessable_entity
      end
    end

    def update
      if @room_type.update(room_type_params)
        redirect_to admin_room_types_path, notice: "room_type was successfully updated"
      else
        render 'edit', status: :unprocessable_entity
      end
    end

    def destroy
      if @room_type.destroy
        redirect_to room_types_url, notice: 'room_type was successfully deleted.'
      else
        redirect_to room_types_url, error: 'Something went wrong'
      end
    end

    private

    def load_room_type
      @room_type = RoomType.find(params[:id])
    end

    def room_type_params
      params.require(:room_type).permit(:description)
    end
  end
end
