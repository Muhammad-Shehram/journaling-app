import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "chips", "field", "suggestions", "quickRow"]
  static values = { existing: String, suggestions: Array }

  connect() {
    this.tags = this.existingValue
      ? this.existingValue.split(",").map(t => t.trim()).filter(Boolean)
      : []
    this.renderChips()
    this.renderQuickTags()
  }

  onKeydown(event) {
    if (event.key === "Enter" || event.key === ",") {
      event.preventDefault()
      this.addTag(this.inputTarget.value)
    } else if (event.key === "Backspace" && this.inputTarget.value === "") {
      this.tags.pop()
      this.renderChips()
      this.renderQuickTags()
    }
  }

  addTag(raw) {
    const name = raw.trim().toLowerCase().replace(/,/g, "")
    if (name && !this.tags.includes(name)) {
      this.tags.push(name)
      this.renderChips()
      this.renderQuickTags()
    }
    this.inputTarget.value = ""
    this.hideSuggestions()
  }

  removeTag(name) {
    this.tags = this.tags.filter(t => t !== name)
    this.renderChips()
    this.renderQuickTags()
  }

  renderChips() {
    this.chipsTarget.innerHTML = ""
    this.tags.forEach(tag => {
      const span = document.createElement("span")
      span.className = "tag-chip"
      span.textContent = tag

      const btn = document.createElement("button")
      btn.type = "button"
      btn.className = "tag-chip__remove"
      btn.dataset.name = tag
      btn.addEventListener("click", () => this.removeTag(tag))

      const icon = document.createElement("i")
      icon.className = "fa-solid fa-xmark"
      btn.appendChild(icon)
      span.appendChild(btn)
      this.chipsTarget.appendChild(span)
    })

    this.fieldTarget.value = this.tags.join(", ")
  }

  renderQuickTags() {
    if (!this.hasQuickRowTarget) return

    const available = this.suggestionsValue
      .filter(t => !this.tags.includes(t))
      .slice(0, 6)

    this.quickRowTarget.innerHTML = ""

    if (!available.length) {
      this.quickRowTarget.style.display = "none"
      return
    }

    this.quickRowTarget.style.display = "flex"
    available.forEach(t => {
      const btn = document.createElement("button")
      btn.type = "button"
      btn.className = "tag-quick-pill"
      btn.textContent = t
      btn.addEventListener("click", () => this.addTag(t))
      this.quickRowTarget.appendChild(btn)
    })
  }

  showSuggestions() {
    const q = this.inputTarget.value.trim().toLowerCase()
    if (!q) { this.hideSuggestions(); return }

    const matches = this.suggestionsValue.filter(t =>
      t.includes(q) && !this.tags.includes(t)
    ).slice(0, 6)

    if (!matches.length) { this.hideSuggestions(); return }

    this.suggestionsTarget.innerHTML = ""
    matches.forEach(t => {
      const btn = document.createElement("button")
      btn.type = "button"
      btn.className = "tag-suggestion"
      btn.dataset.tag = t
      btn.textContent = t
      btn.addEventListener("click", () => this.addTag(t))
      this.suggestionsTarget.appendChild(btn)
    })

    this.suggestionsTarget.style.display = "block"
  }

  hideSuggestions() {
    this.suggestionsTarget.style.display = "none"
  }
}
