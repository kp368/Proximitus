$(document).ready(function() {
  $("#signup-form").submit(function(e) {
    $("#notices div").hide();
    e.preventDefault();
    $.post("/signup", $(this).serialize(), function() {
      $("#notices #success").show();
      $("form input#email").val("");
      ga('send', 'event', 'Conversion', 'Sign-up');
    })
    .error(function() {
      $("#notices #error").show();
    });
  });
  $("#contact-form").submit(function(e) {
    e.preventDefault();
    $.post("/contact", $(this).serialize(), function() {
      $(document).scrollTop(0);
      ga('send', 'event', 'Query', 'Contact us');
    })
  });
  
});