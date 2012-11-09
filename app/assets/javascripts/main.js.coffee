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
    $("ul.statuses > li").removeClass("active")
    li.addClass("active")
    $("#jp").jPlayer
      swfPath: "/swfs",
      supplied: "mp3",
      solution: "flash,html",
      ready: () ->
        $(this).jPlayer("setMedia", {mp3: li.data("audio-path")}).jPlayer("play")

  $("ul.statuses > li").mouseover (event) ->
    readStatus($(this))

  $("ul.statuses > li").mouseout (event) ->
    $(this).removeClass("active")
    $("#jp").jPlayer("stop").jPlayer("destroy")

  initialRead = setTimeout ->
    readStatus($("ul.statuses > li:first"))
  , 4050

  $("#jp").bind $.jPlayer.event.play, () ->
    clearTimeout(initialRead)

  $("#jp").bind $.jPlayer.event.ended, () ->
    next = $("li.active").next("li")
    $("ul.statuses > li").removeClass("active")
    if next.length
      setTimeout ->
        $("#jp").jPlayer("stop").jPlayer("destroy")
        readStatus(next)
      , 1000

  $("#jp2").bind $.jPlayer.event.ended, () ->
    i++
    setTimeout ->
      $("#jp2").jPlayer("stop").jPlayer("destroy")
      playNextBagpipesSelection()
    , 1000

  playNextBagpipesSelection()
