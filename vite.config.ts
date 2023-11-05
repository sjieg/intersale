import { defineConfig } from "vite";
import ViteRails from "vite-plugin-rails";
import ViteRestart from "vite-plugin-restart";

export default defineConfig({
  plugins: [
    ViteRails({
      fullReload: {
        additionalPaths: [
          "config/routes.rb",
          "app/views/**/*",
          "app/helpers/**/*",
          "app/components/**/*",
          "config/locales/**/*",
        ],
        delay: 300,
      },
    }),
    ViteRestart({
      restart: ["my.config.[jt]s"],
    }),
  ],
  css: {
    devSourcemap: true, // this one
  },
  resolve: {
    alias: {
      "~bootstrap": "node_modules/bootstrap",
      "~bi": "node_modules/bootstrap",
    },
  },
});
