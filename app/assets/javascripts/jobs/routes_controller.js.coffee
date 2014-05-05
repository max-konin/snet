class @RoutesController

  edges:  []
  routes: []

  constructor: (polygons_controller, stationsController, map)->
    @stationsController = stationsController
    @map = map

    $('.build_routes').on  'click', @build_routes
    $('.buld_hamilton').on 'click', @build_hamilton_route
    $('.build_mst').on     'click', @build_mst

  build_mst: =>

    return alert "Сначалу нужно построить маршруты" if @edges.length == 0
    url = document.location + '/stations/mst'
    $.ajax url,
      dataType: 'json'
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify  {edges: @edges}
      type: 'POST'
      success: (result) =>
        @connect_stations result



  build_hamilton_route: =>
    @clear_routes()
    stations = @stationsController.getStations()
    @build_route stations

  connect_stations: (stations) ->
    @clear_routes()
    for station in stations
      for connection in station.connections
        @build_route [station, (stations.filter (s) -> s.id == connection.id)[0]]


  build_routes: =>
    @clear_routes()
    stations = @stationsController.getStations()
    for i in [0..(stations.length-2)]
      for j in [i+1..(stations.length-1)]
        @build_route [stations[i], stations[j]], @add_edge

  connect: ->
    url = document.URL + '/stations/connect'
    $.ajax url,
      dataType: 'json'
      contentType: 'application/json'
      data: JSON.stringify {
        edges: @edges
      }
      type: 'POST'


  build_route: (stations, callback = null)->
    points = @stations_to_points(stations)
    ymaps.route(points).then (route) =>
      route.getWayPoints().options.set 'visible', false
      @map.geoObjects.add(route)
      callback(stations, route) unless callback == null
      @routes.push route
    , (error)->
      alert("Возникла ошибка: " + error.message)

  stations_to_points: (stations) ->
    arr = []
    for station in stations
      arr.push [station.latitude, station.longitude]
    arr

  add_edge: (stations, route)=>
    @edges.push {source: stations[0], target: stations[1], weight: route.getLength()}

  clear_routes: ->
    for route in @routes
      @map.geoObjects.remove route
    @routes = []
