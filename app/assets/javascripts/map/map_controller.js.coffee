class @YaMapController

  add_node : (longitude, latitude) ->
    alert 'here'
    $.ajax '/graphs/1/nodes',
      type: 'POST'
      dataType: 'json'
      data: {
        node:{
          longitude: longitude
          latitude:  latitude
        }
      }
      success: (data) ->
        GraphView.get().draw_node(data)





