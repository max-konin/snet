class @PolygonsController

  map: null
  current_polygon: null
  polygins: []

  constructor : (map)->
    @map = map
    $('.add_region').on    'click', @new_region
    $('.create_region').on 'click', @stop_drawing

    #private methods
    @get_points = ->
      return [] if @current_polygon == null
      points = []
      for cord in @current_polygon.geometry.getCoordinates()[0]
        points.push {latitude: cord[0], longitude: cord[1]}
      return points

    @points_to_cords = (points)->
      cords = []
      for p in points
        cords.push [p['latitude'], p['longitude']]
      return cords

  new_region : =>
    @current_polygon = new ymaps.Polygon [], {}, {
      editorDrawingCursor: "crosshair",
      fillColor: '#00FF0088',
      strokeColor: '#0000FF',
      strokeWidth: 5
    };
    @map.geoObjects.add @current_polygon
    @current_polygon.editor.startDrawing()

  stop_drawing : =>
    unless @current_polygon == null
      @current_polygon.editor.stopDrawing()
      @current_polygon.editor.stopEditing()
      @create()
      $('#region-edit').modal('hide')

  create : =>
    url = document.URL + '/regions'
    $.ajax url,
      dataType: 'json'
      contentType: 'application/json'
      data: JSON.stringify {
          region: {
            subscribers_count: $('#subscribers_count').val()
            points: @get_points()
          }
        }
      type: 'POST'
      success: (data) =>
        @current_polygon = null


  get_regions : ->
    url = document.URL + '/regions'
    results = $.ajax(url,
      dataType: 'json'
      type:     'GET'
      async:    false,
    ).responseText;
    $.parseJSON(results)

  redraw_regions : ->
    @polygons = []
    for region in @get_regions()
      polygon = new ymaps.Polygon [@points_to_cords(region['points']), []],
        {},
        {
          editorDrawingCursor: "crosshair",
          fillColor: '#00FF0088',
          strokeColor: '#0000FF',
          strokeWidth: 5
        }
      @map.geoObjects.add polygon
      @polygons.push polygon

      center = new ymaps.Circle([[region.center.latitude, region.center.longitude], 100], {
      }, {
        draggable: false
        strokeColor: "#496DAB"
        fillColor:   "#496DAB"
      });
      @map.geoObjects.add center




