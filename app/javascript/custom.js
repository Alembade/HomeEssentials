document.addEventListener("DOMContentLoaded", function () {
  var forms = document.querySelectorAll("form");
  forms.forEach(function (form) {
    form.querySelectorAll("input[type=hidden]").forEach(function (input) {
      input.removeAttribute("autocomplete");
    });
  });
});
