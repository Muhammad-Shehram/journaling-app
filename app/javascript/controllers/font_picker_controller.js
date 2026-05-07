import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "popup", "option", "titleInput", "tagFooter"]
  static values  = { font: { type: String, default: "default" } }

  connect() {
    this._applyFont(this.fontValue)

    if (this.hasPopupTarget && this.hasTriggerTarget) {
      this._outsideClick = (e) => {
        if (!this.popupTarget.contains(e.target) && !this.triggerTarget.contains(e.target)) {
          this.popupTarget.classList.remove("is-open")
        }
      }
      document.addEventListener("click", this._outsideClick)
    }

    if (this.hasTitleInputTarget) {
      this._autoResize(this.titleInputTarget)
    }

    // Auto-open tag footer on edit if entry already has tags
    if (this.hasTagFooterTarget) {
      const chips = this.tagFooterTarget.querySelector('[data-tag-input-target="chips"]')
      if (chips?.children.length > 0) this.tagFooterTarget.classList.add("is-open")
    }
  }

  disconnect() {
    if (this._outsideClick) document.removeEventListener("click", this._outsideClick)
  }

  toggle(e) {
    e.stopPropagation()
    const opening = !this.popupTarget.classList.contains("is-open")
    this.popupTarget.classList.toggle("is-open")
    if (opening) this._refreshFormatState()
  }

  // Font selection — saves to hidden form field + applies CSS class
  select(e) {
    const font = e.currentTarget.dataset.font
    this._applyFont(font)
    const field = document.getElementById("entry-font-field")
    if (field) field.value = font
    this.popupTarget.classList.remove("is-open")
  }

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

    this._refreshFormatState()
  }

  titleKeydown(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault()
      const trixEl = this.element.querySelector("trix-editor")
      if (trixEl) trixEl.focus()
    }
  }

  autoResizeTitle(event) {
    this._autoResize(event.target)
  }

  _autoResize(textarea) {
    textarea.style.height = "auto"
    textarea.style.height = `${textarea.scrollHeight}px`
  }

  toggleTags() {
    if (!this.hasTagFooterTarget) return
    const open = this.tagFooterTarget.classList.toggle("is-open")
    if (open) {
      const input = this.tagFooterTarget.querySelector('[data-tag-input-target="input"]')
      setTimeout(() => input?.focus(), 260)
    }
  }

  previewPhoto(e) {
    const file = e.target.files[0]
    if (!file) return
    const preview = this.element.querySelector(".canvas__cover-preview")
    const img = this.element.querySelector(".canvas__cover-preview-img")
    if (img) img.src = URL.createObjectURL(file)
    if (preview) preview.style.display = "block"
  }

  removePhoto(e) {
    e.preventDefault()
    const fileInput = this.element.querySelector("#cover-photo-input")
    if (fileInput) fileInput.value = ""
    const flag = document.getElementById("remove-cover-photo-flag")
    if (flag) flag.value = "1"
    const preview = this.element.querySelector(".canvas__cover-preview")
    const img = this.element.querySelector(".canvas__cover-preview-img")
    if (preview) preview.style.display = "none"
    if (img) img.src = ""
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
