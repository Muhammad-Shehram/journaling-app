import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "card", "clearBtn", "noResults", "queryDisplay"]

  filter() {
    const q = this.inputTarget.value.toLowerCase().trim()
    let visibleCount = 0

    this.cardTargets.forEach(card => {
      const title = card.querySelector(".entry-card__title")?.textContent.toLowerCase() || ""
      const matches = q === "" || title.includes(q)
      card.style.display = matches ? "" : "none"
      if (matches) visibleCount++
    })

    if (this.hasClearBtnTarget) {
      this.clearBtnTarget.style.display = q ? "" : "none"
    }

    if (this.hasNoResultsTarget) {
      const noMatch = q !== "" && visibleCount === 0
      this.noResultsTarget.style.display = noMatch ? "" : "none"
      if (this.hasQueryDisplayTarget) this.queryDisplayTarget.textContent = q
    }
  }

  clear() {
    this.inputTarget.value = ""
    this.filter()
    this.inputTarget.focus()
  }
}
