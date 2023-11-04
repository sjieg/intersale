import { Controller } from "@hotwired/stimulus";

// Theme controller to set light and dark theme
// Inspired by https://getbootstrap.com/docs/5.3/customize/color-modes/#javascript
export default class extends Controller {
  static targets = ["lightSwitch", "darkSwitch", "autoSwitch"];

  initialize() {
    this.setTheme(this.getPreferredTheme());
    this.showActiveTheme(this.getPreferredTheme());

    window
      .matchMedia("(prefers-color-scheme: dark)")
      .addEventListener("change", this.systemThemeChanged.bind(this));
  }

  getStoredTheme() {
    return localStorage.getItem("theme");
  }

  setStoredTheme(theme) {
    localStorage.setItem("theme", theme);
  }

  getPreferredTheme() {
    const storedTheme = this.getStoredTheme();
    if (storedTheme) {
      return storedTheme;
    }

    return window.matchMedia("(prefers-color-scheme: dark)").matches
      ? "dark"
      : "light";
  }

  setTheme(theme) {
    this.setButtonActive(theme);
    if (
      theme === "auto" &&
      window.matchMedia("(prefers-color-scheme: dark)").matches
    ) {
      document.documentElement.setAttribute("data-bs-theme", "dark");
    } else {
      document.documentElement.setAttribute("data-bs-theme", theme);
    }
  }

  setButtonActive(theme) {
    this.lightSwitchTarget.classList.remove("active");
    this.darkSwitchTarget.classList.remove("active");
    this.autoSwitchTarget.classList.remove("active");
    if (theme === "light") {
      this.lightSwitchTarget.classList.add("active");
    } else if (theme === "dark") {
      this.darkSwitchTarget.classList.add("active");
    } else if (theme === "auto") {
      this.autoSwitchTarget.classList.add("active");
    }
  }

  showActiveTheme(theme, focus = false) {
    const themeSwitcher = document.querySelector("#bd-theme");
    if (!themeSwitcher) {
      return;
    }

    const themeSwitcherText = document.querySelector("#bd-theme-text");
    const activeThemeIcon = document.querySelector(".theme-icon-active use");
    const btnToActive = document.querySelector(
      `[data-bs-theme-value="${theme}"]`,
    );
    const svgOfActiveBtn = btnToActive
      .querySelector("svg use")
      .getAttribute("href");

    document.querySelectorAll("[data-bs-theme-value]").forEach((element) => {
      element.classList.remove("active");
      element.setAttribute("aria-pressed", "false");
    });

    btnToActive.classList.add("active");
    btnToActive.setAttribute("aria-pressed", "true");
    activeThemeIcon.setAttribute("href", svgOfActiveBtn);
    const themeSwitcherLabel = `${themeSwitcherText.textContent} (${btnToActive.dataset.bsThemeValue})`;
    themeSwitcher.setAttribute("aria-label", themeSwitcherLabel);

    if (focus) {
      themeSwitcher.focus();
    }
  }

  systemThemeChanged() {
    const storedTheme = this.getStoredTheme();
    if (storedTheme !== "light" && storedTheme !== "dark") {
      this.setTheme(this.getPreferredTheme());
    }
  }

  toggleTheme(event) {
    const theme = event.currentTarget.getAttribute("data-bs-theme-value");
    this.setStoredTheme(theme);
    this.setTheme(theme);
    this.showActiveTheme(theme, true);
  }
}
