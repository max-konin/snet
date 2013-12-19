class @GraphView

  instance = null

  class PrivateClass

    nodes = []
    edges = []

    constructor: () ->
      @observers = []

    get_node_cords: (node_id) ->
      node_id_num = parseInt node_id, 10
      result = nodes.filter (n) -> n.id == node_id_num
      return null if result.length == 0
      node = result[0]
      [node.longitude, node.latitude]

    set_map: (map)->
      @map = map

    observe_to: (event, handler) ->
      @observers.push { 'event': event, 'handler': handler }

    draw_edge: (edge) ->
      edges.push edge
      cords_start = @get_node_cords(edge.nodes[0].id)
      cords_end   = @get_node_cords(edge.nodes[1].id)
      line = new ymaps.GeoObject({
        geometry: {
          type: "LineString",
          coordinates: [cords_start,cords_end]
        }
      },
      {
        strokeColor: "#496DAB",
        strokeWidth: 5
      }
      )
      @map.geoObjects.add(line)

    draw_node: (node)->
      nodes.push node
      myCircle = new ymaps.Circle([[node.longitude, node.latitude], 100], {
        balloonContentHeader:  node.name
        hintContent: node.name
      }, {
        draggable: true
        strokeColor: "#496DAB"
        fillColor:   "#496DAB"
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