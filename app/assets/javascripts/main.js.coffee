i = 0

playNextBagpipesSelection = () ->
  samples = ["scotland.mp3", "amazing_grace.mp3", "rowan_tree.mp3"]
  i = 0 if i > samples.length - 1
  $("#jp2").jPlayer
    swfPath: "/swfs",
    supplied: "mp3",
    solution: "flash,html",
    volume: "0.2",
    ready: () ->
      $(this).jPlayer("setMedia", {mp3: "/assets/" + samples[i]}).jPlayer("play")

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
  , 4050

  $("#jp").bind $.jPlayer.event.ended, () ->
    $("ul.statuses > li").removeClass("active")

  $("#jp2").bind $.jPlayer.event.ended, () ->
    i++
    setTimeout ->
      $("#jp2").jPlayer("stop").jPlayer("destroy")
      playNextBagpipesSelection()
    , 1000

  playNextBagpipesSelection()
