class ContactMailer < ApplicationMailer

  default from: 'suporte@+quartos.com'

  def contact_email(contact_form)
    @name = contact_form.name
    @message = contact_form.message
    @contact_email = contact_form.email
    @subject = "Nova Mensagem de Contato"
    mail(to: 'contact@+quartos.com', subject: @subject, reply_to: @contact_email)
  end
end
