json.extract! weather, :id, :weather, :created_at, :updated_at
json.url weather_url(weather, format: :json)
