import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slide"

export default class extends Controller {
  static targets = ["slider"]

  connect() {
    this.active = (this.sliderTarget).firstElementChild
    this.active.classList.add("showing")
    console.log("I am connected")
  }
  slideup() {
    this.active.classList.remove("showing")
    this.active.nextElementSibling.classList.add("showing")
    //  console.log((this.sliderTarget).firstElementChild)
  }

  slidedown(event){
    this.active.classList.remove("showing")
    this.active.nextElementSibling.classList.add("showing")
    console.log(event);
  }

// var slides = document.querySelectorAll('#slides .slide');
// var currentSlide = 0;

// function nextSlide() {
//   goToSlide(currentSlide+1);
// }

// function previousSlide() {
//   goToSlide(currentSlide-1);
// }

// function goToSlide(n) {
//   slides[currentSlide].className = 'slide';
//   currentSlide = (n+slides.length)%slides.length;
//   slides[currentSlide].className = 'slide showing';
// }
}
