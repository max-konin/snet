class @RoutesController

  graph: new Graph()
  routes: []

  constructor: (polygons_controller, stationsController, map)->
    @stationsController = stationsController
    @map = map

    $('.build_routes').on  'click', @build_routes
    $('.buld_hamilton').on 'click', @build_hamilton_route
    $('.build_mst').on     'click', @build_mst

  build_mst: =>
    return alert "Сначалу нужно построить маршруты" if @graph.edges.length == 0
    url = '/graphs/get_mst'
    $.ajax url,
      dataType: 'json'
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify  {edges: @graph.edges}
      type:     'POST'
      success: (result) =>
        @clear_routes()
        for edge in result
          points = []
          for node in edge.nodes
            points.push [node.latitude, node.longitude]
          @build_route points



  build_hamilton_route: =>
    @clear_routes()
    stations = @stationsController.getStations()
    @build_route @stations_to_points(stations)

  build_routes: =>
    @clear_routes()
    @graph = new Graph()
    stations = @stationsController.getStations()
    for i in [0..(stations.length-2)]
      for j in [i+1..(stations.length-1)]
        points = @stations_to_points([stations[i], stations[j]])
        @build_route points, @addition_graph

  build_route: (points, callback = null)->
    ymaps.route(points).then (route) =>
      route.getWayPoints().options.set 'visible', false
      @map.geoObjects.add(route)
      callback(points, route) unless callback == null
      @routes.push route
    , (error)->
      alert("Возникла ошибка: " + error.message)

  stations_to_points: (stations) ->
    arr = []
    for station in stations
      arr.push [station.latitude, station.longitude]
    arr

  addition_graph: (points, route)=>
    nodes = []
    for point in points
      nodes.push new Node(point[0], point[1])
    @graph.nodes += nodes
    edge = new Edge(nodes, route.getLength())
    @graph.edges.push edge

  clear_routes: ->
    for route in @routes
      @map.geoObjects.remove route
    @routes = []
