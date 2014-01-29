json.array!(@regions) do |region|
  json.extract! region, :id, :job_id, :points, :center
end
