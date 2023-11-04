// controllers/tooltip_controller.js
import { Controller } from "@hotwired/stimulus";
import * as bootstrap from "bootstrap";

export default class extends Controller {
  connect() {
    this.element._tooltip = new bootstrap.Tooltip(this.element);
  }

  disconnect() {
    if (this.element._tooltip) {
      this.element._tooltip.dispose();
    }
  }
}
