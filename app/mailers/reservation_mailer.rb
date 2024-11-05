class ReservationMailer < ApplicationMailer

  default from: '<%= @hotel.email %>'

  def cancellation_confirmation(reservation)
    @reservation = reservation
    @user = reservation.user
    @hotel = reservation.hotel
    @room = reservation.room
    @canceled_by = reservation.canceled_by_user

    attachments.inline['logo2.svg'] = File.read(Rails.root.join('app/assets/images/logo2.svg'))

    mail(
      to: email_with_name(@user),
      cc: @hotel.email,
      subject: "Confirmação de Cancelamento - Reserva ##{@reservation.reservation_code}"
    )
  end

  def reservation_confirmation(reservation)
    @reservation = reservation
    @user = reservation.user
    @hotel = reservation.hotel
    @room = reservation.room
    @reservation_by = reservation.user

    attachments.inline['logo2.svg'] = File.read(Rails.root.join('app/assets/images/logo2.svg'))

    mail(
      to: email_with_name(@user),
      cc: @hotel.email,
      subject: "Confirmação da Reserva - Reserva ##{@reservation.reservation_code}"
    )
  end

  private

  def email_with_name(user)
    %("#{user.name}" <#{user.email}>)
  end

end
