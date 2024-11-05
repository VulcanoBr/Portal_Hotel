import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [
    'creditCardFields',
    'boletoFields',
    'pixFields',
    'paymentMethod',
    'boletoSection',
    'pixSection',
    'boletoBarcode',
    'pixCode'
  ]

  connect() {
    this.togglePaymentFieldsOnLoad() // Mostra o campo correto quando a página é carregada
  }

  togglePaymentFields() {
    const selectedMethod = this.currentPaymentMethod()

    if (!selectedMethod) {
      return
    }

    const paymentMethodValue = selectedMethod
    this.hideAllPaymentFields()

    if (paymentMethodValue === 'credit_card') {
      this.creditCardFieldsTarget.classList.remove('d-none')
    } else if (paymentMethodValue === 'boleto') {
      this.boletoFieldsTarget.classList.remove('d-none')
    } else if (paymentMethodValue === 'pix') {
      this.pixFieldsTarget.classList.remove('d-none')
    }
  }

  hideAllPaymentFields() {
    this.creditCardFieldsTarget.classList.add('d-none')
    this.boletoFieldsTarget.classList.add('d-none')
    this.pixFieldsTarget.classList.add('d-none')
  }

  togglePaymentFieldsOnLoad() {
    const paymentMethod = this.currentPaymentMethod()

    if (paymentMethod === 'cartao') {
      this.creditCardFieldsTarget.classList.remove('d-none')
    }
    if (paymentMethod) {
      this.togglePaymentFields()
    }
  }

  currentPaymentMethod() {
    return document.querySelector(
      'input[name="payment_form[payment_method]"]:checked'
    )?.value
  }
}
