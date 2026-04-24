import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "toggleBtn", "list"]

  toggle() {
    const isPassword = this.inputTarget.type === "password"
    this.inputTarget.type = isPassword ? "text" : "password"
    const icon = this.toggleBtnTarget.querySelector("i")
    icon.classList.toggle("fa-eye", !isPassword)
    icon.classList.toggle("fa-eye-slash", isPassword)
  }

  check() {
    const val = this.inputTarget.value
    const rules = [
      { id: "req-length",    test: v => v.length >= 12 },
      { id: "req-uppercase", test: v => /[A-Z]/.test(v) },
      { id: "req-number",    test: v => /[0-9]/.test(v) },
      { id: "req-special",   test: v => /[!@#$%^&*]/.test(v) }
    ]
    rules.forEach(({ id, test }) => {
      const item = this.listTarget.querySelector(`[data-req="${id}"]`)
      if (item) item.classList.toggle("req--met", test(val))
    })
  }
}
