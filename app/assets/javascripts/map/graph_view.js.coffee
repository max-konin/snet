class @GraphView

  instance = null

  class PrivateClass

    nodes = []

    constructor: (@map) ->

    draw_node: (node)->
      nodes.push node
      myCircle = new ymaps.Circle([[node.longitude, node.latitude], 100], {
        balloonContentHeader:  node.name
        hintContent: node.name
      }, {
        draggable: true
      });
      @map.geoObjects.add(myCircle);

#    draw_graph: (graph) ->
#      for node in graph.nodes
#        @draw_node node



  @get: ->
    instance

  @get: (map) ->
    instance ?= new PrivateClass(map)