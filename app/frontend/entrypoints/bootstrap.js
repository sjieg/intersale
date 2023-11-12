import * as bootstrap from "bootstrap";

// Load boostrap carousel in document ready
document.addEventListener("DOMContentLoaded", function () {
    let carouselEl = document.querySelector(".carousel");
    console.log(carouselEl);
    if (carouselEl) {
        new bootstrap.Carousel(carouselEl, {
            interval: 5000,
            pause: false,
        });
    }
});

