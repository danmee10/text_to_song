$(document).ready(function() {
  //highlight words on hover
  $("td.line > span").hover(function(){
    $(this).css("background-color", "yellow");
  },
  function() {
    $(this).css("background-color", "white")
  });

  //options table
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
    //open options table
    $( "td.line > span" ).click(function() {
      $( "#word-options" ).dialog( "open" );
      $( "#word-options > p.word" ).text( $(this).text() + ":").css({"text-transform": "capitalize",
                                                                        "font-weight": "bold"});
      $("#word-options > p.word-id" ).text(this.id).hide()
      $("#word-options > p.line-index" ).text(this.class).hide()
    });
  });


  //synonyms table
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

    //open synonyms table
    $( "#synonyms" ).click(function() {
      var wordId = $(this).siblings("p.word-id").text()
      $( "#synonym-box" ).dialog( "open" );
      $( "#synonym-box > p.word" ).text( "Synonyms for " + $("#word-options > p.word").text()).css({"text-transform": "capitalize",
                                                                                                       "font-weight": "bold"});
      //get synonyms
      $.getJSON("/api/words/" + wordId + ".json", function(data){
        var html =''
        $.each(data.synonyms, function(entryIndex, entry) {
          html += '<li class="' + entry.spelling + '">' + entry.spelling + '</li>';
        });
        $('ul.synonyms').html(html);
        //clickable synonyms
        $('ul.synonyms > li').each(function() {
          $(this).click(function() {
            $.put
            $(this).css("font-weight", "bold");
          });
        });

      });
      return false
    });
  });

  //rhymes table
  $(function() {
    $( "#rhyme-box" ).dialog({
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

    //open rhymes table
    $( "#rhyme-with" ).click(function() {
      var wordId = $(this).siblings("p.word-id").text()
      $( "#rhyme-box" ).dialog( "open" );
      $( "#rhyme-box > p.word" ).text( "Rhymes for " + $("#word-options > p.word").text()).css({"text-transform": "capitalize",
                                                                                                       "font-weight": "bold"});
      //get rhymes
      $.getJSON("/api/words/" + wordId + ".json", function(data){
        var html =''
        $.each(data.rhymes, function(entryIndex, entry) {
          html += '<li class="' + entry.spelling + '">' + entry.spelling + '</li>';
        });
        $('ul.rhymes').html(html);
        //clickable rhymes
        $('ul.rhymes > li').each(function() {
          $(this).click(function() {
            $.put
            $(this).css("font-weight", "bold");
          });
        });

      });
      return false
    });
  });

  //replacement form
  $(function() {
    $( "#replace" ).dialog({
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

    //open replacement form
    $( "#replace-with" ).click(function() {
      var wordId = $(this).siblings("p.word-id").text()
      $( "#replace" ).dialog( "open" );
      $( "#replace > p.word" ).text( "Replace " + $("#word-options > p.word").text()).css({"text-transform": "capitalize",
                                                                                                       "font-weight": "bold"});
    });
  });

  //enlarge and bold options table options on hover
  $("p.tool-belt").hover(function(){
    $(this).css("font-weight", "bold");
    $(this).css("font-size", "+=5");
  },
  function() {
    $(this).css("font-weight", "normal")
    $(this).css("font-size", "-=5");
  });
});
