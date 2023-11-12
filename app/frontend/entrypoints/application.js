console.log("Vite ⚡️ Rails");
console.log(
  "Visit the guide for more information: ",
  "https://vite-ruby.netlify.app/guide/rails",
);

import "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
ActiveStorage.start();

// Add StimulusJS
import "../controllers";

// Activate Turbo Rails
import { cable } from "@hotwired/turbo-rails";
import * as Turbo from "@hotwired/turbo";
Turbo.start();