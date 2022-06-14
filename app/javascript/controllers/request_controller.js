import { Controller } from "@hotwired/stimulus"
import swal from 'sweetalert';


// Connects to data-controller="request"
export default class extends Controller {
  static targets = ["sendRequest", "redirectUrl"]
  // static values = { url: String }
  connect() {
    this.sendRequestTarget.classList.remove("send-request")
    // URL = this.redirectUrlTarget.innerHTML

  }


  SendRequest(){
    // event.preventDefault()
    // const redirectPath = ("http://localhost:3000/users/homepage");
    this.sendRequestTarget.classList.add("send-request");
    // console.log(this.urlValue)
    // const url =
    swal(
      "Request sent!",
      "Continue matching",
      "success"
    )
      // ).then(function() {
      //   console.log(URL)
      //   window.location = URL;
      // })
    // if (event.detail.success) {
    //   window.location.href = this.urlValue;
    // }

  }
}
