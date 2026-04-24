import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "step1", "step2", "step3", "emailInput", "submitBtn"]
  static values = { email: String }

  open() {
    this.overlayTarget.classList.add("is-open")
    this.showStep(1)
  }

  close() {
    this.overlayTarget.classList.remove("is-open")
    setTimeout(() => this.showStep(1), 300)
  }

  advance2() {
    this.showStep(2)
  }

  advance3() {
    this.showStep(3)
    setTimeout(() => this.emailInputTarget.focus(), 50)
  }

  checkEmail() {
    const match = this.emailInputTarget.value.trim().toLowerCase() === this.emailValue.toLowerCase()
    this.submitBtnTarget.disabled = !match
  }

  closeOnBackdrop(event) {
    if (event.target === this.overlayTarget) this.close()
  }

  showStep(n) {
    ;[this.step1Target, this.step2Target, this.step3Target].forEach((el, i) => {
      el.hidden = i + 1 !== n
    })
  }
}
