$ ->
  readStatus = (li) ->
    li.addClass("active")
    $("#jp").jPlayer
      swfPath: "/swfs",
      supplied: "mp3",
      solution: "flash,html",
      ready: () ->
        $(this).jPlayer("setMedia", {mp3: li.data("audio-path")}).jPlayer("play")

  $("ul.statuses > li").mouseenter (event) ->
    readStatus($(this))

  $("ul.statuses > li").mouseleave (event) ->
    $(this).removeClass("active")
    $("#jp").jPlayer("stop").jPlayer("destroy")

  setTimeout ->
    readStatus($("ul.statuses > li:first"))
  , 4250

  playNextBagpipesSelection = () ->
    $("#jp2").jPlayer
      swfPath: "/swfs",
      supplied: "mp3",
      solution: "flash,html",
      volume: "0.2",
      ready: () ->
        $(this).jPlayer("setMedia", {mp3: "/assets/scotland.mp3"}).jPlayer("play")

  $("#jp").bind $.jPlayer.event.ended, () ->
    $("ul.statuses > li").removeClass("active")

  $("#jp2").bind $.jPlayer.event.ended, () ->
    playNextBagpipesSelection()

  playNextBagpipesSelection()
