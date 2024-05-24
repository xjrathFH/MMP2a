//= require rails-ujs
const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

document.addEventListener("DOMContentLoaded", function () {

  if (document.getElementById("closeModal")) {
    var modal = document.getElementById("myModal");
    var closeBtn = document.getElementById("closeModal");

    closeBtn.onclick = function () {
      modal.style.display = "none";
    };

    window.onclick = function (event) {
      if (event.target == modal) {
        modal.style.display = "none";
      }
    };
  }

  //Notifs

  const notifButtons = document.querySelectorAll(".show-result-btn");
  
  if (notifButtons){
    notifButtons.forEach(button => {
      button.addEventListener("click", function() {
        const parentLi = this.closest("li");
        this.style.display = "none";

        const hiddenMessage = parentLi.querySelector(".notif-message");
        hiddenMessage.style.display = "block";

        const notificationId = parentLi.dataset.notificationId;

        // Include the CSRF token in the headers
        fetch(`/notifications/${notificationId}/mark_as_read`, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": csrfToken
          }
        }).then(response => {
          // Check if the notification.didwin is true
          if (response.ok && parentLi.dataset.didwin === "true") {
            confetti({
              particleCount: 100,
              spread: 70,
              origin: { y: 0.6 },
            });
          }
        });
      });
    });
  }

});

function headerDropdown() {
  let list = document.getElementById("dropdown-menu");

  list.classList.toggle("active");
}

function toggleList(){
  let list = document.getElementById("header-mobile-list");

  list.classList.toggle("active");
}