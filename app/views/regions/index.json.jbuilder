json.array!(@regions) do |region|
  json.extract! region, :id, :job_id, :points, :center
  json.set! :connected_to, region.connected_to.nil? ? nil : region.connected_to.id
end
