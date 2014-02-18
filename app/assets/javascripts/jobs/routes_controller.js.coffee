class @RoutesController

  graph: new Graph()
  routes: []

  constructor: (polygons_controller, map)->
    @polygons_controller = polygons_controller
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
    regions = @polygons_controller.get_regions()
    @build_route @regions_to_points(regions)

  build_routes: =>
    @clear_routes()
    @graph = new Graph()
    regions = @polygons_controller.get_regions()
    for i in [0..(regions.length-2)]
      for j in [i+1..(regions.length-1)]
        points = @regions_to_points([regions[i], regions[j]])
        @build_route points, @addition_graph

  build_route: (points, callback = null)->
    ymaps.route(points).then (route) =>
      route.getWayPoints().options.set('preset', 'twirl#blackDotIcon');
      @map.geoObjects.add(route)
      callback(points, route) unless callback == null
      @routes.push route
    , (error)->
      alert("Возникла ошибка: " + error.message)

  regions_to_points: (regions) ->
    arr = []
    for region in regions
      arr.push [region.center.latitude, region.center.longitude]
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
