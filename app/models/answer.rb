class Answer < ApplicationRecord
  @@choices = []

  def get_choices
    @@choices
  end

  def set_choices(choice)
    @@choices = choice
  end

    def add_choice(value)
    unless @@choices.include? value
      @@choices.push value
    end
  end
end
