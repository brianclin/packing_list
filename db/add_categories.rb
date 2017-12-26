def add_attribute(attribute_name)
  class_name = case attribute_name
                 when "Toiletries", "Electronics", "Clothes" then class_name = "Category"
                 when "Snowy", "Rainy", "Cold", "Hot", "Regular", "Warm" then class_name = "Weather"
                 when "Hiking", "Walking", "Clubbing", "Snow Sports", "Swimming" then class_name = "Event"
                 when "Airplane", "Boat", "Bus" then class_name = "Transportation"
               end
  puts(attribute_name.capitalize)
  id = class_name.constantize.find_by("#{class_name.downcase}": attribute_name.capitalize).id
  class_name_id = class_name.downcase + "_id"
  File.open("db/data\/" + attribute_name.downcase + ".txt").each do |line|
    line = line.strip
    item_exists = Item.find_by(name: line)
    if !item_exists
      puts("Adding item " + line)
      item = Item.new(name: line, "#{class_name.downcase}_id": id)
      item.save
    elsif item_exists.send(class_name_id).nil?
        puts("Updated category for " + line)
        item_exists.send(class_name_id + "=", id)
        item_exists.save
    elsif  !Item.find_by("#{class_name_id}": id)
        puts("Adding item " + line)
        item = Item.new(name: line, "#{class_name.downcase}_id": id)
        item.save
    end
  end
end

def add_attribute_boolean(attribute_name)
  puts(attribute_name.capitalize)
  File.open("db\/data\/" + attribute_name.downcase + ".txt").each do |line|
    line = line.strip
    item_exists = Item.find_by(name: line)
    if !item_exists
      puts("Adding item " + line)
      item = Item.new(name: line, "#{attribute_name.downcase}": true)
      item.save
    elsif item_exists.send(attribute_name.downcase).nil?
        puts("Updated category for " + line)
        item_exists.send(attribute_name.downcase + "=", true)
        item_exists.save
    end
  end
end

add_attribute("Toiletries")
add_attribute("Electronics")
add_attribute("Snowy")
add_attribute("Rainy")
add_attribute("Cold")
add_attribute("Hot")
add_attribute("Regular")
add_attribute("Warm")
add_attribute("Hiking")
add_attribute("Walking")
add_attribute("Clubbing")
add_attribute("Snow Sports")
add_attribute("Swimming")
add_attribute("Airplane")
add_attribute("Boat")
add_attribute("Bus")

add_attribute_boolean("International")
add_attribute_boolean("Redeye")
add_attribute_boolean('Domestic')
add_attribute_boolean("Always")