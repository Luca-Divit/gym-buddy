import { Controller } from "@hotwired/stimulus"
import swal from 'sweetalert';


// Connects to data-controller="request"
export default class extends Controller {
  static targets = ["sendRequest"]
  connect() {
    this.sendRequestTarget.classList.remove("send-request")

  }

  SendRequest(event){
    this.sendRequestTarget.classList.add("send-request");
    swal("Request sent!", "Continue matching", "success")
    event.preventDefault();
  }
}
