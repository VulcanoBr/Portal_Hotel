class WelcomeController < ApplicationController

  include Pagy::Backend

  def index
    @hotels = Hotel.order('RANDOM()').limit(3)
    @first_room_details = Hotels::GetRoomPriceDescription.call(@hotels)
    @contact_form = ContactForm.new
  end

  def send_contact
    @contact_form = ContactForm.new(contact_form_params)

    if @contact_form.valid?
      ContactMailer.contact_email(@contact_form).deliver_now
      redirect_to root_path, notice: "Mensagem enviada com sucesso!"
    else
      @hotels = Hotel.order('RANDOM()').limit(3)
      @first_room_details = Hotels::GetRoomPriceDescription.call(@hotels)
      #@contact_form = ContactForm.new
      render :index, status: :unprocessable_entity
    end
  end

  def hotels_list
    @pagy, @hotels = pagy(Hotels::Search.call(term: params[:name]), limit: 6)
    @first_room_details = Hotels::GetRoomPriceDescription.call(@hotels)
  end

  def hotel_details
    @hotel = Hotel.find(params[:id])
    @room_types = Hotels::RoomTypesFetcher.fetch(@hotel)
    @first_room_details = @hotel.rooms.first
    @first_room_description = @hotel.rooms.first.room_type.description

  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:name, :email, :message)
  end

end
