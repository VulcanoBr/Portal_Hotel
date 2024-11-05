module Client
  class ConfirmationsController < ApplicationController

    def new
      @reservation_data = session[:reservation_data]
      @hotel = Hotel.find(@reservation_data["hotel_id"])
      @room = Room.find(@reservation_data["room_id"])
      @payment_data = session[:payment_data]
    end

    def create
      # Pega os dados da reserva armazenados na sessão
      reservation_data = session[:reservation_data]
      payment_data = session[:payment_data]

      # Certifica-se de que os dados da sessão existem
      if reservation_data.nil? || payment_data.nil?
        return redirect_to new_client_confirmation_path, alert: 'Dados da sessão não encontrados. Por favor, tente novamente.'
      end

      # Prepara os parâmetros da reserva
      reservation_params = {
        user_id: reservation_data["user_id"],
        hotel_id: reservation_data["hotel_id"],
        room_id: reservation_data["room_id"],
        check_in_date: Date.parse(reservation_data["check_in_date"]),
        check_out_date: Date.parse(reservation_data["check_out_date"]),
        daily_price: reservation_data["daily_price"]["cents"],
        total_daily: payment_data["total_value"]
      }

      reservation = nil

      # Transação para criar reserva e pagamento
      ActiveRecord::Base.transaction do
        reservation = Reservation.create!(reservation_params)

        # Criação do pagamento baseado nos dados da sessão
        payment_params = {
          reservation_id: reservation.id,
          payment_method: payment_data["payment_method"],
          installments: payment_data["installments"],
          boleto_barcode: payment_data["boleto_barcode"],
          pix_code: payment_data["pix_code"],
          total_value: payment_data["total_value"]
        }
        Payment.create!(payment_params)
      end

      ReservationMailer.reservation_confirmation(reservation).deliver_later

      session.delete(:reservation)
      session.delete(:payment)

      # Redireciona para a página de sucesso
      redirect_to client_confirmation_success_path(id: reservation.id), notice: 'Reserva criada com sucesso!. Você receberá um e-mail com mais informações.'
    rescue ActiveRecord::RecordInvalid => e
      render :new, status: :unprocessable_entity, alert: e.message
    end

    def success
      @reservation = Reservation.find(params[:id])
    end

  end
end
