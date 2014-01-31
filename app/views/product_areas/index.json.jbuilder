json.array!(@product_areas) do |product_area|
  json.extract! product_area, :id, :name
  json.url product_area_url(product_area, format: :json)
end
