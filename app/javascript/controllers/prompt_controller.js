import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor"]

  fill(event) {
    const text = event.currentTarget.dataset.prompt
    const trixEditor = this.editorTarget.querySelector("trix-editor") ||
                       this.editorTarget

    if (trixEditor && trixEditor.editor) {
      trixEditor.editor.loadHTML(`<p>${text}</p>`)
    }
  }
}
