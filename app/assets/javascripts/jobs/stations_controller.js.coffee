class @StationsController

  map: null
  stations: []
  regions: []
  polygons_controller: null

  constructor : (polygons_controller, map)->
    @polygons_controller = polygons_controller
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
    @regions =  @polygons_controller.get_regions()
    for station in @getStations()
      @drawStation station
      @connectStationToRegions station

  redotting: =>
    url = document.URL + '/stations/dotting'
    results = $.ajax(url,
      dataType: 'json'
      type:     'GET'
      async:    false,
    ).responseText;
    @redraw()

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

  connectStationToRegions: (station) =>
    regions_for_station = []
    regions_for_station = @regions.filter (r) -> r.connected_to == station.id
    for region in regions_for_station
      @connectStationToRegion station, region


  connectStationToRegion: (station, region) =>
    ymaps.route([[station.latitude, station.longitude], [region.center.latitude, region.center.longitude]]).then (route) =>
      route.getWayPoints().options.set 'visible', false
      route.options.set { strokeColor: 'DE5757' }
      @map.geoObjects.add(route)
      #@routes.push route
    , (error)->
      alert("Возникла ошибка: " + error.message)