# frozen_string_literal: true

class Question < ApplicationRecord
  def previous
    Question.where(["id < ?", id]).last
  end

  def next
    Question.where(["id > ?", id]).first
  end
end
