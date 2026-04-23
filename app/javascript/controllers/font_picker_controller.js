import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "popup", "option"]
  static values  = { key: { type: String, default: "reflekto_font" } }

  connect() {
    const saved = localStorage.getItem(this.keyValue) || "default"
    this._applyFont(saved)

    // Close popup when clicking outside
    this._outsideClick = (e) => {
      if (!this.element.contains(e.target)) {
        this.popupTarget.classList.remove("is-open")
      }
    }
    document.addEventListener("click", this._outsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this._outsideClick)
  }

  toggle(e) {
    e.stopPropagation()
    this.popupTarget.classList.toggle("is-open")
  }

  select(e) {
    const font = e.currentTarget.dataset.font
    this._applyFont(font)
    localStorage.setItem(this.keyValue, font)
    this.popupTarget.classList.remove("is-open")
  }

  _applyFont(font) {
    const variants = ["default", "serif", "sans", "mono"]
    variants.forEach(v => this.element.classList.remove(`canvas--font-${v}`))
    this.element.classList.add(`canvas--font-${font}`)
    this.optionTargets.forEach(btn => {
      btn.classList.toggle("is-active", btn.dataset.font === font)
    })
  }
}
