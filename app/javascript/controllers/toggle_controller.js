import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "toggleable" ]
  static classes = [ "invisible" ]

  click(){
    this.toggleableTargets.forEach(element => element.classList.toggle(this.invisibleClass))
    // this.toggleableTarget.classList.toggle(this.invisibleClass)  
  }
}