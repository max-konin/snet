class YaMapInitializer

  @graphController = new GraphController

  constructor : ->
    ymaps.ready(@init)

  remove_node: (id) ->
    YaMapInitializer.graphController.remove_node id
    location.reload()

  init : ->
    @myMap = new ymaps.Map 'map', { center:[55, 82.9], zoom: 12, behaviors:['default', 'scrollZoom'] }
    @myMap.behaviors.disable(['dblClickZoom', 'rightMouseButtonMagnifier'])

    @myMap.events.add "dblclick", (e, @yaMapController) ->
      coords = e.get('coordPosition');
      YaMapInitializer.graphController.add_node(coords[0].toPrecision(6), coords[1].toPrecision(6))

    GraphView.get().set_map @myMap
    GraphView.get().draw_nodes YaMapInitializer.graphController.get_nodes()
    GraphView.get().redraw_edges YaMapInitializer.graphController.get_edges()


    #gui handlers
    $ =>
      $('button#add_edge').on('click', =>
        node_start = { id: $( "#start_node" ).val() }
        node_end   = { id: $( "#end_node" ).val() }
        YaMapInitializer.graphController.add_edge node_start, node_end
      )
    #end gui handlers









@yaMapInitializer = new YaMapInitializer
