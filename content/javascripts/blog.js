$(function() {
  $("#sform #q").focus(function() {
    if ($(this).hasClass("default")) {
      $(this).val("");
      $(this).removeClass("default");
    }
  });

  $("#sform #q").blur(function() {
    if ($(this).val().length == 0) {
      $(this).val("Google Search");
      $(this).addClass("default");
    }
  });

  $("#sform").submit(function() {
    $("#q").val($("#q").val() + " +site:blog.teksol.info");
  });
});
