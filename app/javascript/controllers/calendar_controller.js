import { Controller } from "@hotwired/stimulus"

const MONTHS = ["January","February","March","April","May","June",
                "July","August","September","October","November","December"]
const DAYS = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]

export default class extends Controller {
  static targets = ["grid", "monthLabel", "listView", "calView", "listBtn", "calBtn"]
  static values = { dates: Array, baseUrl: String, journalColor: String }

  connect() {
    const today = new Date()
    this.year = today.getFullYear()
    this.month = today.getMonth()
    this.render()
  }

  showList() {
    this.listViewTarget.style.display = ""
    this.calViewTarget.style.display = "none"
    this.listBtnTarget.classList.add("view-toggle--active")
    this.calBtnTarget.classList.remove("view-toggle--active")
  }

  showCal() {
    this.listViewTarget.style.display = "none"
    this.calViewTarget.style.display = ""
    this.listBtnTarget.classList.remove("view-toggle--active")
    this.calBtnTarget.classList.add("view-toggle--active")
    this.render()
  }

  prevMonth() {
    this.month--
    if (this.month < 0) { this.month = 11; this.year-- }
    this.render()
  }

  nextMonth() {
    this.month++
    if (this.month > 11) { this.month = 0; this.year++ }
    this.render()
  }

  render() {
    if (!this.hasGridTarget) return

    this.monthLabelTarget.textContent = `${MONTHS[this.month]} ${this.year}`

    const firstDay = new Date(this.year, this.month, 1).getDay()
    const daysInMonth = new Date(this.year, this.month + 1, 0).getDate()
    const today = new Date()
    const entrySet = new Set(this.datesValue)
    const color = this.journalColorValue || "#3ABF6A"

    let html = DAYS.map(d => `<div class="cal-header">${d}</div>`).join("")

    for (let i = 0; i < firstDay; i++) {
      html += `<div class="cal-day cal-day--empty"></div>`
    }

    for (let d = 1; d <= daysInMonth; d++) {
      const dateStr = `${this.year}-${String(this.month + 1).padStart(2,"0")}-${String(d).padStart(2,"0")}`
      const isToday = today.getFullYear() === this.year && today.getMonth() === this.month && today.getDate() === d
      const hasEntry = entrySet.has(dateStr)

      const url = `${this.baseUrlValue}?from=${dateStr}&to=${dateStr}`
      html += `<a href="${hasEntry ? url : "#"}" class="cal-day${isToday ? " cal-day--today" : ""}${hasEntry ? " cal-day--has-entry" : ""}" style="${hasEntry ? `--cal-color:${color}` : ""}">
        ${d}
        ${hasEntry ? `<span class="cal-dot" style="background:${color}"></span>` : ""}
      </a>`
    }

    this.gridTarget.innerHTML = html
  }
}
