import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "popup", "option"]
  static values  = { key: { type: String, default: "reflekto_font" } }

  connect() {
    const saved = localStorage.getItem(this.keyValue) || "default"
    this._applyFont(saved)

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
    const opening = !this.popupTarget.classList.contains("is-open")
    this.popupTarget.classList.toggle("is-open")
    if (opening) this._refreshFormatState()
  }

  // Font selection — applies CSS class, persists, closes popup
  select(e) {
    const font = e.currentTarget.dataset.font
    this._applyFont(font)
    localStorage.setItem(this.keyValue, font)
    this.popupTarget.classList.remove("is-open")
  }

  // Text / block / list formatting — uses mousedown+preventDefault to keep editor selection
  format(e) {
    e.preventDefault()
    const attr = e.currentTarget.dataset.attr
    const trixEl = this.element.querySelector("trix-editor")
    if (!trixEl) return

    const editor = trixEl.editor
    if (editor.attributeIsActive(attr)) {
      editor.deactivateAttribute(attr)
    } else {
      editor.activateAttribute(attr)
    }

    // Refresh active state on buttons after toggling
    this._refreshFormatState()
  }

  _applyFont(font) {
    const variants = ["default", "serif", "sans", "mono"]
    variants.forEach(v => this.element.classList.remove(`canvas--font-${v}`))
    this.element.classList.add(`canvas--font-${font}`)
    this.optionTargets.forEach(btn => {
      btn.classList.toggle("is-active", btn.dataset.font === font)
    })
  }

  _refreshFormatState() {
    const trixEl = this.element.querySelector("trix-editor")
    if (!trixEl) return

    const editor = trixEl.editor
    this.popupTarget.querySelectorAll("[data-attr]").forEach(btn => {
      btn.classList.toggle("is-active", editor.attributeIsActive(btn.dataset.attr))
    })
  }
}
