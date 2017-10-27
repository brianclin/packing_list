json.extract! item, :id, :name, :category_id, :event_id, :weather_id, :transporation_id, :international, :created_at, :updated_at
json.url item_url(item, format: :json)
