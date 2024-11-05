module Client
  class PaymentsController < ApplicationController

    def new
      @reservation_data = session[:reservation_data]
      @payment_form = PaymentForm.new

      total_value = calculate_total_value(@reservation_data)
      @payment_form.total_value = total_value

    end

    def create
      @payment_form = PaymentForm.new(payment_params)
      if @payment_form.valid?
        session[:payment_data] = payment_params
        redirect_to new_client_confirmation_path
      else
        @reservation_data = session[:reservation_data]
        total_value = calculate_total_value(@reservation_data)
        @payment_form.total_value = total_value
        render :new, status: :unprocessable_entity
      end
    end

    private

    def calculate_total_value(reservation_data)
      price_per_night = Room.find(reservation_data["room_id"]).daily_price
      number_of_nights = (reservation_data["check_out_date"].to_date - reservation_data["check_in_date"].to_date).to_i + 1
      total_value = price_per_night * number_of_nights
      total_value
    end


    def payment_params
      params.require(:payment_form).permit(:payment_method, :card_name, :card_number, :card_expiry_month,
                      :card_expiry_year, :card_cvc, :boleto_barcode, :pix_code, :installments, :total_value)
    end
  end
end
