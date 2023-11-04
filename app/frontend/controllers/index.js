import { Application } from "@hotwired/stimulus";
import { registerControllers } from "stimulus-vite-helpers";
import Autosave from "stimulus-rails-autosave";

// Register out-of-the-box Stimulus controllers
const application = Application.start();
application.register("autosave", Autosave); // https://www.stimulus-components.com/docs/stimulus-rails-autosave/

// Register custom Stimulus controllers
const controllers = import.meta.globEager("./**/*_controller.js");
registerControllers(application, controllers);
