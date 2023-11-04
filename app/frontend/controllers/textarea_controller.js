// controllers/tooltip_controller.js
import { Controller } from "@hotwired/stimulus";
import * as bootstrap from "bootstrap";

export default class extends Controller {
  connect() {
    this.element.addEventListener("keydown", this.handleControlEnter);
  }

  handleControlEnter(event) {
    if (event.key === "Enter" && (event.metaKey || event.ctrlKey)) {
      event.target.form?.requestSubmit();
    }
  }

  disconnect() {
    this.element.removeEventListener("keydown", this.handleControlEnter);
  }
}
