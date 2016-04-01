json.array!(@conferences_affiliations) do |conferences_affiliation|
  json.extract! conferences_affiliation, :id
  json.url conferences_affiliation_url(conferences_affiliation, format: :json)
end
