$ ->
  DoorDuino.init()

DoorDuino = 
  init: ->
    @initPusher()

  initPusher: -> 
    pusher = new Pusher("64df34f71aa202a8ec63")