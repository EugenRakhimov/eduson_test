json.array!(@exponats) do |exponat|
  json.extract! exponat, :id, :link, :item_type
  json.url exponat_url(exponat, format: :json)
end
