
module Admin
  class HotelsController < BaseController

    include Pagy::Backend

    before_action :load_hotel, only: [:edit, :show, :update, :destroy]

    def index
      @pagy, @hotels = pagy(Hotel.order(:name), limit: 6)
    end

    def new
      @hotel = Hotel.new
      @amenities = Amenity.order(:description)
    end

    def edit
      @amenities = Amenity.order(:description)
    end

    def show; end

    def create
      @hotel = Hotel.new(hotel_params)
      if @hotel.save
        flash[:notice] = "Hotel cadastrado com sucesso !!!"
        redirect_to admin_hotels_path
      else
        @amenities = Amenity.order(:description)
        render "new", status: :unprocessable_entity
      end
    end

    def update
      if @hotel.update(hotel_params)
        flash[:notice] = "Hotel atualizado com sucesso !!!"
        redirect_to admin_hotel_url
      else
        @amenities = Amenity.order(:description)
        render "edit", status: :unprocessable_entity
      end
    end

    def destroy
      @hotel.destroy
      flash[:notice] = "Hotel excluido com sucesso !!!"
      redirect_to admin_hotels_path
    end

    def search
      @hotels = Hotel.where("lower(name) ILIKE ?", "%#{params[:q]}%".downcase)

      render layout: false
    end

    private

    def load_hotel
      @hotel = Hotel.find(params[:id])
    end

    def hotel_params
      params.require(:hotel).permit(
                    :name, :location, :email, :telephone, :title, :description,
                    :total_rooms, :floors, :max_rooms_per_floor, :address_zip_code,
                    :address_state, :address_city, :address_neighborhood, :address_street,
                    :address_number, :address_complement, amenity_ids: [], images: []
      )
    end
  end
end
