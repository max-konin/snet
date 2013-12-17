class @GraphView

  instance = null

  class PrivateClass

    nodes = []

    constructor: () ->
      @observers = []

    set_map: (map)->
      @map = map

    observe_to: (event, handler) ->
      @observers.push { 'event': event, 'handler': handler }

    draw_node: (node)->
      nodes.push node
      myCircle = new ymaps.Circle([[node.longitude, node.latitude], 100], {
        balloonContentHeader:  node.name
        hintContent: node.name
      }, {
        draggable: true
      });

      myCircle.events.add('dragend', (e) =>
        coords = e.get('target').geometry.getCoordinates()
        node.longitude = coords[0]
        node.latitude  = coords[1]
        @occurred('node_moved', node)
      )
      @map.geoObjects.add(myCircle);

    draw_nodes: (nodes) ->
      for node in nodes
        @draw_node node

    occurred: (event, target) ->
      observer.handler(event, target) for observer in @observers when observer.event is event
  #end PrivateClass

  @get: () ->
    instance ?= new PrivateClass