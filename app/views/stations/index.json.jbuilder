json.array!(@stations) do |region|
  json.extract! region, :id, :job_id, :latitude, :longitude, :capacity
end
