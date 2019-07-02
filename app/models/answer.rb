class Answer < ApplicationRecord
  @@choices = []
  @@days = ''
  @@removed_items = []

  def initialize
    @@choices.push('always = true')
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
    combined_list = []
    unless @@choices.empty? || @@choices.nil?
      query = @@choices.join(' OR ')
      list = Item.where(query).all
    end
    list.each do |item|
      combined_list.push(item.name)
    end
    puts @@removed_items
    puts @@choices
    @@current_list = combined_list - @@removed_items
  end
end
