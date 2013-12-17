class @GraphView

  instance = null

  class PrivateClass

    nodes = []

    constructor: (@map) ->

    draw_node: (node)->
      nodes.push node
      myCircle = new ymaps.Circle([[node.longitude, node.latitude], 100], {
        balloonContentBody: 'Балун',
        hintContent: 'Хинт'
      }, {
        draggable: true
      });
      @map.geoObjects.add(myCircle);


  @get: ->
    instance

  @get: (map) ->
    instance ?= new PrivateClass(map)