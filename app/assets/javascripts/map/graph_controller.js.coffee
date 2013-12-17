class @GraphController

  constructor: ->
    GraphView.get().observe_to 'node_moved', @node_moved_handler

  update_node: (node)->
    url = document.URL + '/nodes/' + node.id + '.json'
    $.ajax url,
      type: 'PATCH'
      dataType: 'json'
      data: { node: node }

  get_nodes: ->
    url = document.URL + '/nodes'
    results = $.ajax(url,
      dataType: 'json'
      type:     'GET'
      async:    false,
    ).responseText;
    $.parseJSON(results)


  add_node: (longitude, latitude) ->
    url = document.URL + '/nodes'
    $.ajax url,
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

  node_moved_handler: (event, target) =>
    @update_node target



