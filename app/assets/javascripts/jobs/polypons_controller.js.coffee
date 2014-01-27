class @PolygonsController

  map: null

  constructor : (map)->
    @map = map
    $('.add_region').on 'click', @create

  create : =>
    polygon = new ymaps.Polygon [], {}, {
      editorDrawingCursor: "crosshair",
      editorMaxPoints: 5,
      fillColor: '#00FF00',
      strokeColor: '#0000FF',
      strokeWidth: 5
    };
    @map.geoObjects.add polygon
    polygon.editor.startDrawing()
