import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const elements = document.querySelectorAll(".ln-reveal")

    // Pre-mark elements already in (or above) the viewport before activating
    // CSS hiding — prevents blank content if JS and CSS load in different orders
    elements.forEach((el) => {
      if (el.getBoundingClientRect().top < window.innerHeight) {
        el.classList.add("is-visible")
      }
    })

    // Activate CSS-controlled hiding only after pre-marking visible elements
    document.body.classList.add("scroll-reveal-ready")

    this._obs = new IntersectionObserver((entries) => {
      entries.forEach((e) => {
        if (e.isIntersecting) {
          e.target.classList.add("is-visible")
          this._obs.unobserve(e.target)
        }
      })
    }, { threshold: 0 })

    elements.forEach((el) => this._obs.observe(el))
  }

  disconnect() {
    if (this._obs) this._obs.disconnect()
    document.body.classList.remove("scroll-reveal-ready")
  }
}
