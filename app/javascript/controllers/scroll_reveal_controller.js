import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this._obs = new IntersectionObserver((entries) => {
      entries.forEach((e) => {
        if (e.isIntersecting) {
          e.target.classList.add("is-visible")
          this._obs.unobserve(e.target)
        }
      })
    }, { threshold: 0.12 })

    document.querySelectorAll(".ln-reveal").forEach((el) => this._obs.observe(el))
  }

  disconnect() {
    if (this._obs) this._obs.disconnect()
  }
}
