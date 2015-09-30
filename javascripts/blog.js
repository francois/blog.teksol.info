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

  function tagDatabase() {
    ADGEAR.tags.data.embed({ "id": "70", "chip_key": "25a790a0df3e012d2fb80024e87a30c2" });
  }

  function tagRails() {
    ADGEAR.tags.data.embed({ "id": "73", "chip_key": "8a4beaa0df43012d2fba0024e87a30c2" });
  }

  var qmatch = document.referrer.match(/(?:\?|&)q=(.+?)(?:&|$)/)
  if (qmatch) {
    ADGEAR.tags.data.init();
    var query = unescape(qmatch[0].substring(3, qmatch[0].length - 1));
    if ((/rails|activerecord|active|record|active|support|activesupport|action|controller|actionpack|actioncontroller|activeresource|resource/i).test(query)) tagRails();
    if ((/mysql|postgresql|database|db|mongo|cassandra|redis/i).test(query)) tagDatabase();
  }
});
