class ContactForm
  include ActiveModel::Model

  attr_accessor :name, :email, :message

  validates :name, presence: { message: "não pode ficar em branco" }
  validates :email, presence: { message: "não pode ficar em branco" },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "formato inválido" }
  validates :message, presence: { message: "não pode ficar em branco" }
end
