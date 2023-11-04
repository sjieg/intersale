// controllers/tooltip_controller.js
import { Controller } from "@hotwired/stimulus";
import * as bootstrap from "bootstrap";

export default class extends Controller {
  connect() {
    this.element._popover = new bootstrap.Popover(this.element, {
      container: "body",
      html: true,
      trigger: "focus",
      placement: "bottom",
    });
  }

  disconnect() {
    if (this.element._popover) {
      this.element._popover.dispose();
    }
  }
}
