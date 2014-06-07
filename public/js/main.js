$(document).ready(function() {
  $("#signup-form").submit(function(e) {
    $("#notices div").hide();
    e.preventDefault();
    $.post("/signup", $(this).serialize(), function() {
      $("#notices #success").show();
      $("form input#email").val("");
    })
    .error(function() {
      $("#notices #error").show();
    });
  });
});