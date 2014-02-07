class @RoutesController

  constructor: (polygons_controller, map)->
    @polygons_controller = polygons_controller
    @map = map

    $('.build_routes').on 'click', @build_routes
    $('.buld_hamilton').on 'click', @build_hamilton_route

  build_hamilton_route: =>
    regions = @polygons_controller.get_regions()
    @build_route @regions_to_points(regions)

  build_routes: =>
    regions = @polygons_controller.get_regions()
    for i in [0..(regions.length-2)]
      for j in [i+1..(regions.length-1)]
        @build_route @regions_to_points([regions[i], regions[j]])

  build_route: (points)->
    ymaps.route(points).then (route) =>
      route.getWayPoints().options.set('preset', 'twirl#blackDotIcon');
      @map.geoObjects.add(route)
    , (error)->
      alert("Возникла ошибка: " + error.message)

  regions_to_points: (regions) ->
    arr = []
    for region in regions
      arr.push [region.center.latitude, region.center.longitude]
    arr
