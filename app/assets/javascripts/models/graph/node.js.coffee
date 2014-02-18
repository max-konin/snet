class @Node
  latitude: 0
  longitude: 0
  constructor: (latitude, longitude)->
    @longitude = longitude
    @latitude  = latitude

  get_cords: ->
    [@latitude, @longitude]