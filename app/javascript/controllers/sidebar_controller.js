import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "overlay"]

  // Mobile: overlay toggle
  toggle() {
    this.element.classList.toggle("sidebar-open")
  }

  close() {
    this.element.classList.remove("sidebar-open")
  }

  // Desktop: toggle between full sidebar and narrow rail
  toggleDesktop() {
    this.element.classList.toggle("sidebar-collapsed")
  }
}
