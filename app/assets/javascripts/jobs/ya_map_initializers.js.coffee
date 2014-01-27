class YaMapInitializer

  polygons_controller: null

  constructor : ->
    ymaps.ready(@init)

  init : ->
    @myMap = new ymaps.Map 'map', { center:[55, 82.9], zoom: 12, behaviors:['default', 'scrollZoom'] }
    @myMap.behaviors.disable(['dblClickZoom', 'rightMouseButtonMagnifier'])
    polygons_controller = new PolygonsController(@myMap)





@yaMapInitializer = new YaMapInitializer
