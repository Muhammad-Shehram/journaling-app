import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.timer = setTimeout(() => this.dismiss(), 4000)
  }

  disconnect() {
    clearTimeout(this.timer)
  }

  dismiss() {
    this.element.style.animation = "toast-out 0.25s ease forwards"
    setTimeout(() => this.element.remove(), 250)
  }
}
