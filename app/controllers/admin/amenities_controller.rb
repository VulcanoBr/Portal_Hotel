
module Admin
  class AmenitiesController < BaseController

    include Pagy::Backend

    before_action :load_amenity, only:  [ :show, :edit, :update, :destroy ]

    def index
      @pagy, @amenities = pagy(Amenity.order(:description), limit: 6)
    end

    def new
      @amenity = Amenity.new
    end

    def show; end

    def edit; end

    def create
      @amenity = Amenity.new(amenity_params)
      if @amenity.save
        redirect_to admin_amenities_path, notice: "amenity successfully created"
      else
        render 'new', status: :unprocessable_entity
      end
    end

    def update
      if @amenity.update(amenity_params)
        redirect_to admin_amenities_path, notice: "amenity was successfully updated"
      else
        render 'edit', status: :unprocessable_entity
      end
    end

    def destroy
      if @amenity.destroy
        redirect_to amenities_url, notice: 'amenity was successfully deleted.'
      else
        redirect_to amenities_url, error: 'Something went wrong'
      end
    end

    private

    def load_amenity
      @amenity = Amenity.find(params[:id])
    end

    def amenity_params
      params.require(:amenity).permit(:description)
    end
  end
end
