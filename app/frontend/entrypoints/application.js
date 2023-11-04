console.log("Vite ⚡️ Rails");
console.log(
  "Visit the guide for more information: ",
  "https://vite-ruby.netlify.app/guide/rails",
);

// Add StimulusJS
import "../controllers";

// Activate Turbo Rails
import { cable } from "@hotwired/turbo-rails";
import * as Turbo from "@hotwired/turbo";
Turbo.start();

// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')
