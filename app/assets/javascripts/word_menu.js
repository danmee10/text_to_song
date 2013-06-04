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
      // $( "#word-options" ).dialog( "open" );

      $( this ).popover({
        trigger: 'click',
          html : true,
        content: function () {
                   return $('#tool-buttons').html();
                 }
      });





      $( "#word-options > p.word" ).text( $(this).text() + ":").css({"text-transform": "capitalize",
                                                                        "font-weight": "bold"});
      $("#word-options > p.word-id" ).text(this.id).hide();
      $("#word-options > p.line-index" ).text(this.class).hide();
      $("#word-options > p.line-id" ).text($(this).closest("tr").attr('id')).hide();
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
      var wordId = $(this).siblings("p.word-id").text();
      var lineId = $(this).siblings("p.line-id").text();
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
            $.ajax({
                    type: "PUT",
                    url: "/api/lines/" + lineId + ".json",
                    data: { old_word: wordId, new_word: $(this).text() },
                    dataType: "json"
                  });
            $(this).css("font-weight", "bold");
            $( "#synonym-box" ).dialog( "close" );
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
      var lineId = $(this).siblings("p.line-id").text();
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
              $.ajax({
                    type: "PUT",
                    url: "/api/lines/" + lineId + ".json",
                    data: { old_word: wordId, new_word: $(this).text() },
                    dataType: "json"
                  });
            $(this).css("font-weight", "bold");
            $( "#rhyme-box" ).dialog( "close" );
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
      var wordId = $(this).siblings("p.word-id").text();
      var lineId = $(this).siblings("p.line-id").text();
      $( "#replace" ).dialog( "open" );
      $( "#replace > p.word" ).text( "Replace " + $("#word-options > p.word").text()).css({"text-transform": "capitalize",
                                                                                              "font-weight": "bold"});
      $('#replace-button').click(function() {
        $.ajax({
          type: "PUT",
          url: "/api/lines/" + lineId + ".json",
          data: { old_word: wordId, new_word: $("#appendedInputButton").val() },
          dataType: "json"
        });
        $( "#replace" ).dialog( "close" );
      });
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
