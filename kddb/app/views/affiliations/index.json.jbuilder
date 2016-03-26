json.array!(@affiliations) do |affiliation|
  json.extract! affiliation, :id
  json.url affiliation_url(affiliation, format: :json)
end
