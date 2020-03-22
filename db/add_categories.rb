# frozen_string_literal: true

require 'English'

def subcategory_id(class_name, attribute_name)
  subcategory = class_name.constantize.find_by("#{class_name.downcase}": attribute_name)
  unless subcategory
    class_name.constantize.new("#{class_name.downcase}": attribute_name.to_s).save
    subcategory = class_name.constantize.find_by(
      "#{class_name.downcase}": attribute_name
    )
  end
  subcategory.id
end

def add_item(item_name, class_name_id)
  puts('Adding item ' + item_name)
  item = Item.new(name: item_name, "#{class_name_id}": id)
  item.save
end

def update_item(item_name, class_name_id, id)
  puts('Updated category for ' + line)
  item_name.send(class_name_id + '=', id)
  item_name.save
end

def item_needs_update?(item, class_name_id, id)
  !item || !Item.find_by("#{class_name_id}": id)
end

def update_items(file, id, class_name)
  class_name_id = class_name.downcase + '_id'
  File.open(file).each do |line|
    line = line.strip
    item_exists = Item.find_by(name: line)
    if item_needs_update?(item_exists, class_name_id, id)
      add_item(line, class_name_id)
    elsif item_exists.send(class_name_id).nil?
      update_item(item_exists, class_name_id, id)
    end
  end
end

def add_attribute(attribute_name)
  class_name = case attribute_name
               when 'Toiletries', 'Electronics', 'Clothes' then 'Category'
               when 'Snowy', 'Rainy', 'Cold', 'Hot', 'Regular', 'Warm' then 'Weather'
               when 'Hiking', 'Walking', 'Clubbing', 'Snow Sports', 'Swimming' then 'Event'
               when 'Airplane', 'Boat', 'Bus' then 'Transportation'
               end
  puts(attribute_name.capitalize)
  id = subcategory_id(class_name, attribute_name.capitalize)
  file = "db/data\/" + attribute_name.downcase + '.txt'
  update_items(file, id, class_name)
end

def update_item_boolean(item_name, attribute_name)
  item_exists = Item.find_by(name: item_name)
  if !item_exists
    puts('Adding item ' + item_name)
    item = Item.new(name: item_name, "#{attribute_name}": true)
    item.save
  elsif item_exists.send(attribute_name).nil?
    puts('Updated category for ' + item_name)
    item_exists.send(attribute_name + '=', true)
    item_exists.save
  end
end

def add_attribute_boolean(attribute_name)
  puts(attribute_name.capitalize)
  File.open("db\/data\/" + attribute_name.downcase + '.txt').each do |line|
    line = line.strip
    update_item_boolean(line, attribute_name.downcase)
  end
end

def add_question(question, table_name, line_number)
  puts("Adding question #{question} #{table_name} #{line_number}")
  question = Question.new(
    question: question,
    position: line_number,
    table_name: table_name
  )
  question.save
end

def update_question(question, table_name, line_number)
  puts("Updated question #{line_number}")
  question_exists.update(
    question: question,
    position: line_number,
    table_name: table_name
  )
  question_exists.save
end

def question_exists?(line_number)
  Question.find_by(id: line_number)
end

def question_updates?(question, table_name, line_number)
  Question.find_by(
    question: question,
    position: line_number,
    table_name: table_name
  )
end

def parse_question(line)
  line = line.split(',')
  question = line[0].strip
  table_name = line[1].nil? ? '' : line[1].strip
  [question, table_name]
end

def add_questions
  puts('Questions')
  File.open('db/data/questions.txt').each do |line|
    question_info = parse_question(line)
    question = question_info[0]
    table_name = question_info[1]
    if !question_exists?($INPUT_LINE_NUMBER)
      add_question(question, table_name, $INPUT_LINE_NUMBER)
    elsif !question_updates?(question, table_name, $INPUT_LINE_NUMBER)
      update_question(question, table_name, $INPUT_LINE_NUMBER)
    end
  end
end

def add_categories
  puts('Categories')
  File.open('db/data/categories.txt').each do |line|
    line = line.strip
    category_exists = Category.find_by(category: line)
    if !category_exists
      puts("Adding category #{line}")
      category = Category.new(category: line)
      category.save
    elsif !category_exists
      puts("Updated category #{line}")
      category_exists.update(category: line)
      category_exists.save
    end
  end
end

add_categories
add_questions

add_attribute('Toiletries')
add_attribute('Electronics')
add_attribute('Snowy')
add_attribute('Rainy')
add_attribute('Cold')
add_attribute('Hot')
add_attribute('Regular')
add_attribute('Warm')
add_attribute('Hiking')
add_attribute('Walking')
add_attribute('Clubbing')
add_attribute('Snow Sports')
add_attribute('Swimming')
add_attribute('Airplane')
add_attribute('Boat')
add_attribute('Bus')

add_attribute_boolean('International')
add_attribute_boolean('Normal')
add_attribute_boolean('Domestic')
add_attribute_boolean('Always')
