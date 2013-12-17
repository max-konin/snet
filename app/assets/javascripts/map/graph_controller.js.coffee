class @GraphController

  get_nodes : ->
    results = $.ajax('/graphs/1/nodes',
      dataType: 'json'
      type:     'GET'
      async:    false,
    ).responseText;
    $.parseJSON(results)


  add_node : (longitude, latitude) ->
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





