import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btn", "field"]

  select(event) {
    const btn = event.currentTarget
    const mood = btn.dataset.mood

    // Toggle off if already selected
    if (this.fieldTarget.value === mood) {
      this.fieldTarget.value = ""
      this.btnTargets.forEach(b => b.classList.remove("mood-btn--active"))
      return
    }

    this.fieldTarget.value = mood
    this.btnTargets.forEach(b => b.classList.remove("mood-btn--active"))
    btn.classList.add("mood-btn--active")
  }
}
