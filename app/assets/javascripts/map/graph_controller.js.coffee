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

  get_edges: ->
    url = document.URL + '/edges'
    results = $.ajax(url,
      dataType: 'json'
      type:     'GET'
      async:    false,
    ).responseText;
    $.parseJSON(results)
  add_edge: (node_1, node_2) ->
    url = document.URL + '/edges'
    $.ajax url,
      type: 'POST'
      dataType: 'json'
      data: {
        edge:{
          nodes: [node_1.id, node_2.id]
        }
      }
      success: (data) ->
        GraphView.get().draw_edge(data)

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




