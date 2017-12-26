json.extract! item, :id, :name, :category_id, :event_id, :weather_id, :transportation_id, :international, :redeye, :domestic, :always, :created_at, :updated_at
json.url item_url(item, format: :json)
