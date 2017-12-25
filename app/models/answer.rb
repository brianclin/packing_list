class Answer < ApplicationRecord
  @@choices = []

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
end
