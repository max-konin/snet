json.array!(@stations) do |station|
  json.extract! station, :id, :job_id, :latitude, :longitude, :capacity
  json.connections station.connections, :id
end
