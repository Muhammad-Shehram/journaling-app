import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["preview", "colorField", "nameInput"]

  connect() {
    const initial = this.colorFieldTarget.value || "#3ABF6A"
    this.element.style.setProperty("--journal-color", initial)
  }

  selectColor(event) {
    const color = event.currentTarget.dataset.color
    this.colorFieldTarget.value = color
    this.element.style.setProperty("--journal-color", color)
    this.element.querySelectorAll(".color-swatch").forEach(s => s.classList.remove("color-swatch--active"))
    event.currentTarget.classList.add("color-swatch--active")
  }

  fillName(event) {
    this.nameInputTarget.value = event.currentTarget.dataset.name
    this.nameInputTarget.focus()
  }
}
