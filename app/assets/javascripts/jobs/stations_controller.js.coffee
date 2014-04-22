class @StationsController

  map: null
  stations: []

  constructor : (map)->
    @map = map
    $('.dotting').on 'click', @redotting
    @redraw()

  getStations: ->
    url = document.URL + '/stations'
    results = $.ajax(url,
      dataType: 'json'
      type:     'GET'
      async:    false,
    ).responseText;
    $.parseJSON(results)

  redraw: ->
    for station in @getStations()
      @drawStation station

  redotting: =>
    url = document.URL + '/stations/dotting'
    results = $.ajax(url,
      dataType: 'json'
      type:     'GET'
      async:    false,
    ).responseText;
    for station in $.parseJSON(results)
      @drawStation station

  drawStation: (station) =>
    station_geo = new ymaps.GeoObject(
      {
        geometry: {
          type: "Point",
          coordinates: [station.latitude, station.longitude]
        },
        properties: {
          iconContent: station.capacity,
          balloonContent: "<p>Станция</p><p>Макс. нагрузка: #{station.capacity}</p>"
        }
      },
      {preset: 'twirl#redStretchyIcon'} )
    @map.geoObjects.add station_geo
    @stations.push station_geo
