# frozen_string_literal: true

require 'English'

def add_attribute(attribute_name)
  class_name = case attribute_name
               when 'Toiletries', 'Electronics', 'Clothes' then class_name = 'Category'
               when 'Snowy', 'Rainy', 'Cold', 'Hot', 'Regular', 'Warm' then class_name = 'Weather'
               when 'Hiking', 'Walking', 'Clubbing', 'Snow Sports', 'Swimming' then class_name = 'Event'
               when 'Airplane', 'Boat', 'Bus' then class_name = 'Transportation'
               end
  puts(attribute_name.capitalize)
  sub_category = class_name.constantize.find_by("#{class_name.downcase}": attribute_name.capitalize)
  unless sub_category
    class_name.constantize.new("#{class_name.downcase}": attribute_name.capitalize.to_s).save
    sub_category = class_name.constantize.find_by("#{class_name.downcase}": attribute_name.capitalize)
  end
  id = sub_category.id
  class_name_id = class_name.downcase + '_id'
  File.open("db/data\/" + attribute_name.downcase + '.txt').each do |line|
    line = line.strip
    item_exists = Item.find_by(name: line)
    if !item_exists
      puts('Adding item ' + line)
      item = Item.new(name: line, "#{class_name.downcase}_id": id)
      item.save
    elsif item_exists.send(class_name_id).nil?
      puts('Updated category for ' + line)
      item_exists.send(class_name_id + '=', id)
      item_exists.save
    elsif !Item.find_by("#{class_name_id}": id)
      puts('Adding item ' + line)
      item = Item.new(name: line, "#{class_name.downcase}_id": id)
      item.save
    end
  end
end

def add_attribute_boolean(attribute_name)
  puts(attribute_name.capitalize)
  File.open("db\/data\/" + attribute_name.downcase + '.txt').each do |line|
    line = line.strip
    item_exists = Item.find_by(name: line)
    if !item_exists
      puts('Adding item ' + line)
      item = Item.new(name: line, "#{attribute_name.downcase}": true)
      item.save
    elsif item_exists.send(attribute_name.downcase).nil?
      puts('Updated category for ' + line)
      item_exists.send(attribute_name.downcase + '=', true)
      item_exists.save
    end
  end
end

def add_questions
  puts('Questions')
  File.open('db/data/questions.txt').each do |line|
    line = line.split(',')
    question = line[0].strip
    table_name = line[1].nil? ? '' : line[1].strip
    question_exists = Question.find_by(id: $INPUT_LINE_NUMBER)
    question_updates = Question.find_by(question: question, position: $INPUT_LINE_NUMBER, table_name: table_name)
    if !question_exists
      puts("Adding question #{question} #{table_name} #{$INPUT_LINE_NUMBER}")
      question = Question.new(question: question, position: $INPUT_LINE_NUMBER, table_name: table_name)
      question.save
    elsif !question_updates
      puts("Updated question #{$INPUT_LINE_NUMBER}")
      question_exists.update(question: question, position: $INPUT_LINE_NUMBER, table_name: table_name)
      question_exists.save
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
