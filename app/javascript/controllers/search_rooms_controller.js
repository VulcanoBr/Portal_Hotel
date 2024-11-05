import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['hotelHidden', 'checkInDate', 'checkOutDate', 'results']

  connect() {
    this.debouncedSearch = this.debounce(this.searchRooms, 300)
  }

  updateHotel() {
    this.searchRooms()
    this.debouncedSearch()
  }

  updateDates() {
    this.searchRooms()
    this.debouncedSearch()
  }

  searchRooms() {
    const hotelId = this.hotelHiddenTarget.value
    const checkInDate = this.checkInDateTarget.value
    const checkOutDate = this.checkOutDateTarget.value

    if (hotelId && checkInDate && checkOutDate && checkInDate <= checkOutDate) {
      const urlBase = new URL(this.urlValue, window.location.href).toString()
      const url = `/client/reservations/search_rooms?hotel_id=${hotelId}&check_in_date=${checkInDate}&check_out_date=${checkOutDate}`

      fetch(url, {
        headers: {
          Accept: 'text/vnd.turbo-stream.html'
        }
      })
        .then(response => response.text())
        .then(html => {
          Turbo.renderStreamMessage(html)

          this.element.dataset.searchPerformed = 'true'
        })
    } else {
      this.element.dataset.searchPerformed = 'false'
    }
  }

  debounce(func, wait) {
    let timeout
    return (...args) => {
      clearTimeout(timeout)
      timeout = setTimeout(() => func.apply(this, args), wait)
    }
  }
}
