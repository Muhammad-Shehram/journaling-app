import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "dropdown", "pillLabel"]
  static values  = {
    journals:      Array,
    newJournalUrl: String,
    currentId:     Number
  }

  connect() {
    this._activeId = this.currentIdValue
    this._renderList()

    this._outsideClick = (e) => {
      if (!this.element.contains(e.target)) this._close()
    }
    document.addEventListener("click", this._outsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this._outsideClick)
  }

  toggle(e) {
    e.stopPropagation()
    this.dropdownTarget.classList.contains("is-open") ? this._close() : this._open()
  }

  _open()  { this.dropdownTarget.classList.add("is-open") }
  _close() { this.dropdownTarget.classList.remove("is-open") }

  _select(journal) {
    // Update the pill label and colour
    this.pillLabelTarget.textContent = journal.name
    this.triggerTarget.style.setProperty("--journal-pill-color", journal.color)

    // Rewire the form to POST to the selected journal's entries path
    const form = this.element.closest("form")
    if (form) form.action = journal.path

    // Update checkmark
    this._activeId = journal.id
    this._renderList()
    this._close()
  }

  _renderList() {
    const d = this.dropdownTarget
    d.innerHTML = ""

    this.journalsValue.forEach(journal => {
      const btn = document.createElement("button")
      btn.type = "button"
      btn.className = "journal-picker-item" + (journal.id === this._activeId ? " is-current" : "")
      btn.addEventListener("click", () => this._select(journal))

      const dot = document.createElement("span")
      dot.className = "journal-picker-item__dot"
      dot.style.background = journal.color

      const name = document.createElement("span")
      name.className = "journal-picker-item__name"
      name.textContent = journal.name

      btn.appendChild(dot)
      btn.appendChild(name)

      if (journal.id === this._activeId) {
        const check = document.createElement("i")
        check.className = "fa-solid fa-check journal-picker-item__check"
        btn.appendChild(check)
      }

      d.appendChild(btn)
    })

    // Divider
    const hr = document.createElement("hr")
    hr.className = "journal-picker-divider"
    d.appendChild(hr)

    // New Journal link
    const a = document.createElement("a")
    a.href = this.newJournalUrlValue
    a.className = "journal-picker-new"

    const icon = document.createElement("i")
    icon.className = "fa-solid fa-plus"
    const text = document.createTextNode(" New Journal")
    a.appendChild(icon)
    a.appendChild(text)
    d.appendChild(a)
  }
}
