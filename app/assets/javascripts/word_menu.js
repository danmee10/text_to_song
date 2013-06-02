$(document).ready(function() {
  $("td.line > span").hover(function(){
    $(this).css("background-color", "yellow");
  },
  function() {
    $(this).css("background-color", "white")
  });

  // $(function() {
  //   $("#menu").menu();
  // });

  // $("td.line > span").click(function() {
  //   $(this).menu({ position: { my: "left top", at: "right-5 top+5"}, menus: "span" });
  //   $(this).append('<p class="menu-element">Synonyms</p>')
  // });

  $(function() {
    $( "#word-options" ).dialog({
      autoOpen: false,
      show: {
        effect: "blind",
        duration: 10
      },
      hide: {
        effect: "explode",
        duration: 10
      },
      position: {
        at: "left center", of: window
      }
    });

    $( "td.line > span" ).click(function() {
      $( "#word-options" ).dialog( "open" );
      $( "#word-options > p.word" ).text( $(this).text() + ":").css({"text-transform": "capitalize",
                                                                        "font-weight": "bold"});
      $("#word-options > p.word-id" ).text(this.id).hide()
    });
  });

  $(function() {
    $( "#synonym-box" ).dialog({
      autoOpen: false,
      show: {
        effect: "blind",
        duration: 10
      },
      hide: {
        effect: "explode",
        duration: 10
      },
      position: {
        at: "right center", of: window
      }
    });

    $( "#synonyms" ).click(function() {
      var wordId = $(this).siblings("p.word-id").text()
      $( "#synonym-box" ).dialog( "open" );
      $( "#synonym-box > p.word" ).text( "Synonyms for " + $("#word-options > p.word").text()).css({"text-transform": "capitalize",
                                                                                                       "font-weight": "bold"});
      $.getJSON("/api/words/" + wordId + ".json", function(data){
        var html =''
        $.each(data.synonyms, function(entryIndex, entry) {
          html += '<li>' + entry.spelling + '</li>';
        });
        $('ul.synonyms').html(html);
      });
      return false
    });
  });

  $("p.tool-belt").hover(function(){
    $(this).css("font-weight", "bold");
    $(this).css("font-size", "+=5");
  },
  function() {
    $(this).css("font-weight", "normal")
    $(this).css("font-size", "-=5");
  });
});