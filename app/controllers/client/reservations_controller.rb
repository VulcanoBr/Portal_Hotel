module Client
  class ReservationsController < ApplicationController

    include Pagy::Backend

    before_action :authenticate_user!

    before_action :set_reservation, only: [:reservation_cancel, :process_cancellation_reservation]

    def new
      @reservation_form = ReservationForm.new
      @rooms = []
      @search_performed = false
      @min_date = Date.today + 1

      if params[:hotel_id] ? @hotel = Hotel.find_by(id: params[:hotel_id]) : @hotel = nil

      end
    end

    def create
      @reservation_form = ReservationForm.new(reservation_params)
      if @reservation_form.check_in_date.present? && @reservation_form.check_out_date.present?
        @reservation_form.check_in_date = Date.parse(@reservation_form.check_in_date)
        @reservation_form.check_out_date = Date.parse(@reservation_form.check_out_date)
      end
      @reservation_form.daily_price = Room.find(reservation_params[:room_id]).daily_price  if @reservation_form.room_id.present?
      if @reservation_form.valid?
        session[:reservation_data] = @reservation_form # Armazena temporariamente os dados da reserva

        redirect_to new_client_payment_path
      else

        @rooms = []
        if (@reservation_form.hotel_id.present? && @reservation_form.check_in_date.present? && @reservation_form.check_out_date.present? &&
            (@reservation_form.check_in_date <= @reservation_form.check_out_date) )
          @rooms = Room.available_between(@reservation_form.hotel_id, @reservation_form.check_in_date, @reservation_form.check_out_date)
          @search_performed = true
        else
          @search_performed = false
        end
        @min_date = Date.today + 1
        render :new, status: :unprocessable_entity
      end
    end

    def search_rooms
      @hotel = Hotel.find(params[:hotel_id])
      @check_in_date = Date.parse(params[:check_in_date])
      @check_out_date = Date.parse(params[:check_out_date])
      @rooms = @hotel.rooms.available_between(@hotel.id, @check_in_date, @check_out_date)
      @search_performed = true
      respond_to do |format|
        format.html { render partial: 'available_rooms', locals: { rooms: @rooms } }
        format.turbo_stream {
          render turbo_stream: turbo_stream.update('available_rooms', partial: 'available_rooms',
                  locals: { rooms: @rooms, search_performed: @search_performed,
                            check_in_date: @check_in_date, check_out_date: @check_out_date })
        }
      end
    end

    def reservation_histories
      @pagy, @reservations = pagy(current_user.reservations.includes(:hotel, :room, :payment).order(check_in_date: :desc), limit: 6)
    end

    def reservation_details
      @reservation = Reservation.find(params[:id])
    end

    def reservation_cancel
      @reservation = Reservation.find(params[:id])
      @cancellation_reasons = Reservation.available_cancellation_reasons

      if request.patch?
        if @reservation.update(reservation_params)
          @reservation.update(status: 'canceled')
          redirect_to reservations_path, notice: 'Reserva cancelada com sucesso.'
        else
          render :reservation_cancel, stutus: :unprocessable_entity
        end
      end
    end

    def process_cancellation_reservation
      if @reservation.cancel!(
          cancellation_reason_id: cancellation_params[:cancellation_reason_id],
          cancellation_notes: cancellation_params[:cancellation_notes],
          user_id: current_user.id,
        )
        ReservationMailer.cancellation_confirmation(@reservation).deliver_later
        redirect_to reservation_histories_client_reservations_path,
                    notice: 'Reserva cancelada com sucesso. Você receberá um e-mail com mais informações.'
      else
        flash.now[:alert] = 'Não foi possível cancelar a reserva. Por favor, verifique os erros.'
        render :reservation_cancel, status: :unprocessable_entity
      end
    end

    private

    def set_reservation
      @reservation = current_user.reservations.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to reservations_path, alert: 'Reserva não encontrada.'
    end

    def cancellation_params
      params.require(:reservation).permit(:cancellation_reason_id, :cancellation_notes)
    end

    def reservation_params
      params.require(:reservation_form).permit(:user_id, :hotel_id, :room_id, :check_in_date,
            :check_out_date, :daily_price)
    end



  end
end
