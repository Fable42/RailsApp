import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "replies", "toggleLink" ]

  toggle(event) {
    event.preventDefault()
    this.repliesTarget.classList.toggle('d-none')
    const linkText = this.repliesTarget.classList.contains('d-none') ? 'Show replies' : 'Hide replies'
    this.toggleLinkTarget.innerHTML = linkText
  }
}
