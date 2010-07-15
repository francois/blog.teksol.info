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

  function log(data) {
    if (typeof(window.console) !== "undefined") {
      window.console.log.apply(data, arguments);
    }
  }

  function tagPiston() {
    log("tagPiston() - for real");
    ADGEAR.tags.data.embed({ "id": "13", "chip_key": "5b2ccf20dd0a012c13a40024e87a30c2" });
  }

  function tagRefactoring() {
    log("tagRefactoring() - for real");
    ADGEAR.tags.data.embed({ "id": "7", "chip_key": "5e1653d0ce47012c13900024e87a30c2" });
  }

  ADGEAR.tags.data.init();

  var qmatch = document.referrer.match(/(?:\?|&)q=(.+?)(?:&|$)/)
  if (qmatch) {
    log("qmatch OK: %o", qmatch);
    var query = unescape(qmatch[0].substring(3, qmatch[0].length - 1));
    log("query OK: %o", query);
    if ((/refactoring/i).test(query)) tagRefactoring();
    if ((/piston/i).test(query)) tagPiston();
  } else {
    log("qmatch nil");
  }
});
