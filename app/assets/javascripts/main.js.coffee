$ ->
  $("ul.statuses > li").mouseenter (event) ->
    url = $(event.target).closest("[data-audio-path]").data("audio-path")
    $("#jp").jPlayer
      swfPath: "/swfs",
      supplied: "mp3",
      solution: "flash,html",
      ready: () ->
        $(this).jPlayer("setMedia", {mp3: url}).jPlayer("play")

  $("ul.statuses > li").mouseleave ->
    $("#jp").jPlayer("stop").jPlayer("destroy")

  $("ul.status > li:first").mouseenter()