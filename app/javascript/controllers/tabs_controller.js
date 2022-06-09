import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["tab", "tab2", "content", "content2"]

  // connect() {
  //   console.log(this.tabTarget)
  // }

  activeClass(event) {
    event.preventDefault()
    if ( this.tabTarget.classList.contains("active") ) {
      this.tabTarget.classList.remove("active")
      this.tab2Target.classList.add("active")
      this.content2Target.classList.remove("d-none")
      this.contentTarget.classList.add("d-none")


    } else if ( this.tab2Target.classList.contains("active") ) {
      this.tabTarget.classList.add("active")
      this.tab2Target.classList.remove("active")
      this.contentTarget.classList.remove("d-none")
      this.content2Target.classList.add("d-none")
    }

  }
}
