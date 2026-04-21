import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "overlay"]

  toggle() {
    this.element.classList.toggle("sidebar-open")
  }

  close() {
    this.element.classList.remove("sidebar-open")
  }
}
