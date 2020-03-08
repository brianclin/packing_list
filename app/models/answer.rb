class Answer < ApplicationRecord
  @@choices = []
  @@days = ''
  @@removed_items = []

  def initialize
    @@choices.push('always = true')
    @@choices.push('category_id = 1')
    @@choices.push('category_id = 2')
  end

  def get_choices
    @@choices
  end

  def set_choices(choice)
    @@choices = choice
  end

  def add_choice(value)
    if @@choices.nil? || @@choices != value
      @@choices.push value
    end
  end

  def get_days
    @@days
  end

  def set_days(days)
    @@days = days
  end

  def remove_choice(value)
    @@choices.delete_if { |choice| choice == value }
  end

  def remove_from_list(item)
    @@removed_items.push(item.strip)
  end

  def removed_items
    @@removed_items
  end

  def set_removed_items(items)
    @@removed_items = items
  end


  def list
    combined_list  = { clothing: [], electronics: [], toiletries: [], accessories: [] }
    unless @@choices.empty? || @@choices.nil?
      query = @@choices.join(' OR ')
      list = Item.where(query).all
    end
    list.each do |item|
      if item.clothing?
        combined_list[:clothing].push(item.name)
      elsif item.category_id == 1
        combined_list[:toiletries].push(item.name)
      elsif item.category_id == 2
        combined_list[:electronics].push(item.name)
      else
        combined_list[:accessories].push(item.name)
      end
    end
    puts @@removed_items
    puts @@choices
    combined_list.each do |key, val|
      combined_list[key] = combined_list[key] - @@removed_items
    end
    puts combined_list
    combined_list
  end
end
