class YaMapInitializer

  @yaMapController = new YaMapController

  constructor : ->
    ymaps.ready(@init)

  init : ->
    @myMap = new ymaps.Map 'map', { center:[55, 82.9], zoom: 12 }

    @myMap.events.add "click", (e, @yaMapController) ->
      coords = e.get('coordPosition');
      YaMapInitializer.yaMapController.add_node(coords[0].toPrecision(6), coords[1].toPrecision(6))

    GraphView.get @myMap

@yaMapInitializer = new YaMapInitializer
