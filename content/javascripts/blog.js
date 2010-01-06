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

  function tagPiston() {
    ADGEAR.env.add_load_listener(function() {
      ADGEAR.delivery.data("13", "5b2ccf20dd0a012c13a40024e87a30c2")
    });
  }

  function tagRefactoring() {
    ADGEAR.env.add_load_listener(function() {
      ADGEAR.delivery.data("7", "5e1653d0ce47012c13900024e87a30c2");
    });
  }

  var qmatch = document.referrer.match(/(?:\?|&)q=(.+)(?:&|$)/);
  var query = qmatch[0].substring(3, qmatch[0].length - 1);
  if (query.test(/refactoring/i)) tagRefactoring();
  if (query.test(/piston/i)) tagPistong();
});
