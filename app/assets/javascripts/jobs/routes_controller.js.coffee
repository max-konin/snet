class @RoutesController

  constructor: (polygons_controller, map)->
    @polygons_controller = polygons_controller
    @map = map

    $('.build_routes').on 'click', @build_routes

  build_routes: =>
    regions = @polygons_controller.get_regions()
    for i in [0..(regions.length-2)]
      for j in [i+1..(regions.length-1)]
        @build_route regions[i], regions[j]

  build_route: (r1, r2)->
    ymaps.route([[r1.center.latitude, r1.center.longitude],
      [r2.center.latitude, r2.center.longitude]]
    ).then (route) =>
      route.getWayPoints().options.set('preset', 'twirl#blackDotIcon');
      @map.geoObjects.add(route)
    , (error)->
      alert("Возникла ошибка: " + error.message)
