class Answer < ApplicationRecord
  @@choices = []
  @@days = ''

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
    @@choices.delete_if {|choice| choice == value }
  end
end
