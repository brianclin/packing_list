# frozen_string_literal: true

class Question < ApplicationRecord
  def previous
    Question.where(['id < ?', id]).last
  end

  def next
    Question.find_by(id: id + 1)
  end
end
