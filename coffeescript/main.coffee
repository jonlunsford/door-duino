$ ->
  DoorDuino.init()

DoorDuino =
  messageDisplay: "#main-alert"

  init: ->
    @initPusher()
    @initNotifier(".notify", "click")

  initPusher: -> 
    pusher = new Pusher "64df34f71aa202a8ec63"
    channel = pusher.subscribe "notification"
    channel.bind "notify", (data) -> 
      # DoorDuino.clearMessages()
      DoorDuino.sendMessage data.message, data.type

  initNotifier: (elem, event) ->
    $elem = $(elem)
    $elem.on event, this, (e) -> 
      e.preventDefault()
      $.post("/notify")

  sendMessage: (message, type) ->
    $display = $(DoorDuino.messageDisplay)
    $display.text message
    $display.prop "class", type

  clearMessages: () ->
    $display = $(DoorDuino.messageDisplay)
    $display.text ""
    $display.prop "class", "info"
