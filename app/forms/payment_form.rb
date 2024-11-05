
class PaymentForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :card_name, :card_number, :card_expiry_month, :card_expiry_year,
                :card_cvc, :payment_method, :total_value, :installments, :boleto_barcode, :pix_code

  validates :card_name, :card_number, :card_expiry_month, :card_expiry_year, :card_cvc,
            :installments, presence: true, if: -> { payment_method == "credit_card" }

  validates :payment_method, presence: true

  validate :validate_payment_method_details

  def validate_payment_method_details
    case payment_method
    when "credit_card"
      validates_credit_card_fields
    when "boleto"
      validates_boleto_fields
    when "pix"
      validates_pix_fields
    else
      errors.add(:payment_method, "método de pagamento inválido")
    end
  end

  def validates_credit_card_fields
    errors.add(:card_name, "não pode ficar em branco") if card_name.blank?
    errors.add(:card_number, "não pode ficar em branco") if card_number.blank?
    errors.add(:card_expiry_month, "é obrigatório") if card_expiry_month.blank?
    errors.add(:card_expiry_year, "é obrigatório") if card_expiry_year.blank?
    errors.add(:card_cvc, "é obrigatório") if card_cvc.blank?
  end

  def validates_boleto_fields
    errors.add(:boleto_barcode, "não pode ficar em branco") if boleto_barcode.blank?
  end

  def validates_pix_fields
    errors.add(:pix_code, "não pode ficar em branco") if pix_code.blank?
  end

  def valid_payment_data?
    valid?  # Isso apenas valida os dados, mas não salva nada no banco
  end
end
