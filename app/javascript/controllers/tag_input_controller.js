import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "chips", "field", "suggestions"]
  static values = { existing: String, suggestions: Array }

  connect() {
    this.tags = this.existingValue
      ? this.existingValue.split(",").map(t => t.trim()).filter(Boolean)
      : []
    this.renderChips()
  }

  onKeydown(event) {
    if (event.key === "Enter" || event.key === ",") {
      event.preventDefault()
      this.addTag(this.inputTarget.value)
    } else if (event.key === "Backspace" && this.inputTarget.value === "") {
      this.tags.pop()
      this.renderChips()
    }
  }

  addTag(raw) {
    const name = raw.trim().toLowerCase().replace(/,/g, "")
    if (name && !this.tags.includes(name)) {
      this.tags.push(name)
      this.renderChips()
    }
    this.inputTarget.value = ""
    this.hideSuggestions()
  }

  removeTag(name) {
    this.tags = this.tags.filter(t => t !== name)
    this.renderChips()
  }

  renderChips() {
    this.chipsTarget.innerHTML = this.tags.map(tag =>
      `<span class="tag-chip">
        ${tag}
        <button type="button" class="tag-chip__remove" data-name="${tag}">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </span>`
    ).join("")

    this.chipsTarget.querySelectorAll(".tag-chip__remove").forEach(btn => {
      btn.addEventListener("click", () => this.removeTag(btn.dataset.name))
    })

    this.fieldTarget.value = this.tags.join(", ")
  }

  showSuggestions() {
    const q = this.inputTarget.value.trim().toLowerCase()
    if (!q) { this.hideSuggestions(); return }

    const matches = this.suggestionsValue.filter(t =>
      t.includes(q) && !this.tags.includes(t)
    ).slice(0, 6)

    if (!matches.length) { this.hideSuggestions(); return }

    this.suggestionsTarget.innerHTML = matches.map(t =>
      `<button type="button" class="tag-suggestion" data-tag="${t}">${t}</button>`
    ).join("")

    this.suggestionsTarget.querySelectorAll(".tag-suggestion").forEach(btn => {
      btn.addEventListener("click", () => this.addTag(btn.dataset.tag))
    })

    this.suggestionsTarget.style.display = "block"
  }

  hideSuggestions() {
    this.suggestionsTarget.style.display = "none"
  }
}
