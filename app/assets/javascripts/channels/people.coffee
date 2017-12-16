App.people = App.cable.subscriptions.create "PeopleChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    App.people.drop("")

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    max = 1
    min = 0
    rn = Math.floor( Math.random() * (max - min + 1) ) + min;
    if rn == 1
      box_a = square_container(400, 100)
    else
      box_a = oblong_container(300, 100)
    Matter.World.add(window.global_engine.world, box_a)

  drop: ->
    @perform 'drop'
