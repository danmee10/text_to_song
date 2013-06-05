$(document).ready(function() {

//highlight words yellow on hover
  $("td.line > span").hover(function(){
    $(this).css("background-color", "yellow");
  },
  function() {
    $(this).css("background-color", "white")
  });

//popover buttons
  $('#tool-buttons').hide();

//define options popover
  $( "td.line" ).popover({
    trigger: 'manual',
       html: true,
  placement: "left",
      title: function() { return spanText(); },
    content: function () {
               return $('#tool-buttons').html();
             }
  });

// open options popover
  $( "td.line > span" ).click(function(evt) {
              var word = $(this).html();
              var wordId = this.id;
              var lineId = $(this).parents("tr").attr("id");
              var wordUnderExamination = $(this);

              evt.stopPropagation();
              $("span.selected-word").removeClass("selected-word");
              $(this).addClass('selected-word');
              $( "td.line" ).not($(this).parent()).popover('hide');
              $(this).parent().popover('toggle');

              $("div.popover #synonyms").on("click",function() {
                proposeSynonyms(wordId,lineId,wordUnderExamination);
              });

              $("div.popover #rhyme-with").on("click",function() {
                proposeRhymes(wordId,lineId,wordUnderExamination);
              });

              $("div.popover #replace-with").on("click",function() {
                replacementForm(wordId,lineId,wordUnderExamination);
              });
            });

// close options popover, but only remove selected-word class if a dialog box is not open
  $("body").click(function() {
    var synonymIsOpen = $( "#synonym-box" ).dialog( "isOpen" );
    var rhymeIsOpen = $( "#rhyme-box" ).dialog( "isOpen" );
    var replaceIsOpen = $( "#replace" ).dialog( "isOpen" );
    if (synonymIsOpen || rhymeIsOpen || replaceIsOpen) {
      $("td.line").popover('hide')
    } else {
      $("td.line").popover('hide').children("span").removeClass("selected-word");
    }
  });

//popover title
  function spanText()
  {
    return $("span.selected-word").text() + ":";
  }

//synonyms table
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
      at: "center", of: window
    },
    minHeight: 200,
    maxHeight: 400,
    width: 300,
    draggable: true,
    modal: true,
    open: function (event, ui) {
            $('#synonym-box').css('overflow', 'scroll');
          }
  });

//open synonyms table
  proposeSynonyms = function(wordId,lineId,wordUnderExamination) {
    $( "#synonym-box" ).dialog( "open" );
    $( ".ui-dialog" ).addClass( "modal" );

    $('#synonym-box').bind('dialogclose', function(event) {
      wordUnderExamination.removeClass("selected-word");
      $("ul.synonyms").html("<li></li>");
      $("ul.synonyms").text("");
      $(".progress-striped").show();
    });

    $( "#synonym-box > p.word" ).text( "Synonyms for " + wordUnderExamination.text() + ":").css({"text-transform": "capitalize",
                                                                                                     "font-weight": "bold"});
    //get synonyms
    $.getJSON("/api/words/" + wordId + ".json", function(data){
      var html =''
      $.each(data.synonyms, function(entryIndex, entry) {
        html += '<li class="replacement-word">' + entry.spelling + '</li>';
      });

      $(".progress-striped").hide();

      $('ul.synonyms').html(html);
      if ($('ul.synonyms').is(':empty')) {
        $('ul.synonyms').text("Sorry, no synonyms found");
      }
      //clickable synonyms
      $('ul.synonyms > li').each(function() {
        $(this).click(function() {

          var newWord = $(this).text();
          $.ajax({
                  type: "PUT",
                  url: "/api/lines/" + lineId + ".json",
                  data: { old_word: wordId, new_word: newWord },
                  dataType: "json"
                });

          wordUnderExamination.html(newWord);
          $(this).css("font-weight", "bold");

          $( "#synonym-box" ).dialog( "close" );
        });
      });
    });
    return false;
  }

//rhymes table
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
      at: "center", of: window
    },
    minHeight: 200,
    maxHeight: 400,
    width: 300,
    modal: true,
    open: function (event, ui) {
            $('#rhyme-box').css('overflow', 'scroll');
          }
  });

//open rhymes table
  proposeRhymes = function(wordId,lineId,wordUnderExamination) {
    $( "#rhyme-box" ).dialog( "open" );

    $('#rhyme-box').bind('dialogclose', function(event) {
      $("span.selected-word").removeClass("selected-word");
      $("ul.rhymes").html("<li></li>");
      $("ul.rhymes").text("");
      $(".progress-striped").show();
    });

    $( "#rhyme-box > p.word" ).text( "Rhymes for " + wordUnderExamination.text() + ":").css({"text-transform": "capitalize",
                                                                                                     "font-weight": "bold"});
    //get rhymes
    $.getJSON("/api/words/" + wordId + ".json", function(data){
      var html =''
      $.each(data.rhymes, function(entryIndex, entry) {
        html += '<li class="replacement-word">' + entry.spelling + '</li>';
      });

      $(".progress-striped").hide();

      $('ul.rhymes').html(html);
      if ($('ul.rhymes').is(':empty')) {
        $('ul.rhymes').text("Sorry, no rhymes found");
      }
      //clickable rhymes
      $('ul.rhymes > li').each(function() {
        $(this).click(function() {

            var newWord = $(this).text();
            $.ajax({
                  type: "PUT",
                  url: "/api/lines/" + lineId + ".json",
                  data: { old_word: wordId, new_word: newWord },
                  dataType: "json"
                });

          wordUnderExamination.html(newWord);

          $(this).css("font-weight", "bold");
          $( "#rhyme-box" ).dialog( "close" );
        });
      });
    });
    return false
  }

//replacement form
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
      at: "center", of: window
    },
    width: 300,
    modal: true
  });

//open replacement form
  replacementForm = function(wordId,lineId,wordUnderExamination) {
    $( "#replace" ).dialog( "open" );

    $('#replace').bind('dialogclose', function(event) {
      $("span.selected-word").removeClass("selected-word");
    });

    $( "#replace > p.word" ).text( "Replace " + wordUnderExamination.text() + " with:").css("font-weight", "bold");
    $('#replace-button').click(function() {
      var newWord = $(this).siblings().val();;
      $.ajax({
        type: "PUT",
        url: "/api/lines/" + lineId + ".json",
        data: { old_word: wordId, new_word: newWord },
        dataType: "json"
      });

      wordUnderExamination.html(newWord);
      $( "#replace" ).dialog( "close" );
    });
  }
});
